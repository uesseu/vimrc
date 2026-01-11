import { parse, stringify } from "jsr:@std/toml";
import { argv } from 'node:process';


let directory = 'presets'
let data = {}
for (const fname of Deno.readDirSync(directory)) {
  const d = parse(Deno.readTextFileSync(`${directory}/${fname.name}`))
  for (const name in d)
    data[name] = d[name]
}

const required = (data)=>{
  for (const d in data) {
    if (data[d].require && data[d].enabled) {
      return true
    }
  }
  return false
}

while (required(data)){
  for (const name in data){
    if ( data[name].enabled ){
      if (data[name].require){
        for (const require of data[name].require){
          data[require].enabled = true
        }
        delete data[name].require
      }
    }
  }
}

for (const name in data){
  if ( !data[name].enabled === true ) {
    delete data[name]
  }
  else {
    delete data[name].enabled
  }
}

for (const name in data){
}
console.log(JSON.stringify(data))
