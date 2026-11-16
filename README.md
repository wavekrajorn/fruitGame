# fruitGame

Rojo project for the Roblox place "Untitled Experience" (placeId 90689482367098, universeId 10777109688).

## Layout

```
default.project.json      maps folders to the DataModel
src/shared/Apple.luau     builds the apple Model from basic parts  -> ReplicatedStorage.Shared
src/server/Main.server.luau   places the apple if Workspace has none -> ServerScriptService.Server
src/client/Main.client.luau   client entry (empty)                -> StarterPlayerScripts.Client
selene.toml, stylua.toml  lint and format config
.github/workflows/ci.yml  lint, format check, build
```

Workspace is marked `$ignoreUnknownInstances`, so Rojo will not delete the hand-placed Apple or anything else in it.

## Setup (one time)

1. Install the tools: `brew install rojo stylua selene` (tested with Rojo 7.7.1, StyLua 2.6.0, selene 0.32.0).
2. Install the Rojo plugin in Studio, then run `rojo serve` and press Connect in the plugin.

## Daily use

- `rojo serve`: live-sync src/ into Studio
- `stylua src`: format
- `selene src`: lint
- `rojo build default.project.json --output build/fruitGame.rbxl`: build a place file

## Publishing via Open Cloud (not set up)

Create an API key in the Creator Dashboard with place publish permission for this universe. Add GitHub secrets `ROBLOX_API_KEY`, `PLACE_ID`, `UNIVERSE_ID`, then uncomment the `publish` job in ci.yml. Never commit the key.

## Open items

- Not a git repo yet.
- Tool versions are not pinned for the team (no rokit.toml; Rokit is not in Homebrew).
- ci.yml still uses the Rokit setup action, which needs a rokit.toml. It must be changed before CI can pass, and has never been run.
- `stylua --check`, `selene` and `rojo build` pass locally (checked after installing the tools).
