//########################################
//# Dpp config typescript file.
//########################################

// Place for toml files of plugins.
const dir="plugin_config"

import { BaseConfig, ContextBuilder, Dpp, Plugin } from "jsr:@shougo/dpp-vim@~3.1.0/config";

interface Toml {
  hooks_file?: string;
  ftplugins?: Record<string, string>;
  plugins: Plugin[];
};

interface LazyResult {
  plugins: Plugin[];
  stateLines: string[];
}

interface Args {
    denops
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
}

interface PluginState {
  plugins: Plugin[]
  stateLines: string[]
}

const filter_fname = (fname) => {
  if (fname.endsWith(".toml")) {
    return true
  }
  if (fname[0] === '_') {
    return false
  }
  return false
}

const namesort = (x, y)=>[x.name, y.name].sort()[0] === x.name? -1 : 1
const getDir = (name): DirEntry=> Array.from(Deno.readDirSync(name)).sort(namesort)

export class Config extends BaseConfig {
  override async config(args: Args): Promise<PluginState> {
    args.contextBuilder.setGlobal({ protocols: ["git"] });
    const [context, options] = await args.contextBuilder.get(args.denops);
    const plugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];
    const tomls: Toml[] = [];

    // Toml
    const flavorDir = `${args.basePath}/${dir}`
    for (const pack of getDir(args.basePath + "/" + dir)){
      const flavors = getDir(`${flavorDir}/${pack.name}`)
      for (const flavor of flavors){
        if (!flavor.isDirectory) continue
        const tomlFnames = getDir(`${flavorDir}/${pack.name}/${flavor.name}`)
        for (const tomlFname of tomlFnames){
          if (!filter_fname(tomlFname.name)) continue
          const toml: Toml | undefined = await args.dpp.extAction(
            args.denops, context, options, "toml", "load",
            {
              path: `${flavorDir}/${pack.name}/${flavor.name}/${tomlFname.name}`,
              options: { lazy: true, sourced: true },
            },
          )
          if (toml) {
            tomls.push(toml);
          }
        }
      }
    }

    for (const toml of tomls) {
      for (const plugin of toml.plugins) {
        plugins[plugin.name] = plugin;
      }
      if (toml.ftplugins) {
        for (const filetype in toml.ftplugins) {
          if (ftplugins[filetype]) {
            ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
          } else {
            ftplugins[filetype] = toml.ftplugins[filetype];
          }
        }
      }

      if (toml.hooks_file) {
        hooksFiles.push(toml.hooks_file);
      }
    }

    const lazyResult: LazyResult | undefined = await args.dpp.extAction(
      args.denops, context, options, "lazy", "makeState",
      { plugins: Object.values(plugins), },
    )

    return {
      ftplugins,
      hooksFiles,
      plugins: lazyResult?.plugins ?? [],
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
