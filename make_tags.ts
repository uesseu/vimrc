import { parse } from "https://deno.land/std@0.167.0/flags/mod.ts";
const args: object = parse(Deno.args)

const makeTag = async (fname: string, detectFunc: Function, writeFunc: Function) =>{
  const text: string = await Deno.readTextFile(fname);
  const lines = text.split('\n').filter(detectFunc)
  const codes = lines.map(writeFunc(fname))
  return codes
}

const isTypeofExt = (ext: string) => (fname: string) => fname.slice(fname.length - ext.length) === ext

const makeFnames = async (dirname: string, isFileOf: Function) => {
  let result: string[] = []
  for await (const dirEntry of Deno.readDir(dirname))
    if (dirEntry.isFile && isFileOf(dirEntry.name))
      result.push(dirname + dirEntry.name)
    else if(dirEntry.isDirectory)
      result = result.concat(await makeFnames(dirname + dirEntry.name + '/', isFileOf))
  return result
}

const makeTags = async (detector, writer) => {
  let result: string[] = []
  for (const fname of await makeFnames(args._[0], isTypeofExt('.vim')))
    for (const tag of await makeTag(fname, detector, writer))
      result.push(tag)
  return result.sort()
}


const detector = (text: string) => text.includes('"# ', 0)
const tocWriter = (fname: string) => (text: string) =>{
  const path = fname.split('/')
  const label = path[path.length - 1].split('.')[0].replace('-', '_')
  const capitalLabel = label[0].toUpperCase() + label.slice(1)
  return ('" ' + capitalLabel + '_' + text.slice(3) + ': in ' + fname)
}

const tagWriter = (fname: string) => (text: string) => {
  const path = fname.split('/')
  const label = path[path.length - 1].split('.')[0].replace('-', '_')
  const capitalLabel = label[0].toUpperCase() + label.slice(1)
  return capitalLabel + '_' + text.slice(3) + '\t' + fname + '\t/^' + text + '/'
}

if (args.tag === true){
  console.log('!_TAG_FILE_SORTED	1')
  let tags = await makeTags(detector, tagWriter)
  tags.push(`README	${args._[0]}README.md	norm gg`)
  for (const tag of tags.sort()) console.log(tag)
}
else if (args.toc === true){
  console.log('"========================================')
  console.log('"# Table_of_contents')
  console.log('"========================================')
  console.log('" README:')
  for (const tag of await makeTags(detector, tocWriter))
    console.log(tag)
}
