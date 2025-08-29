# Service Explorer Neovim Plugin

This plugin helps you explore service dependencies defined in `SeedHawkGateway.json`. It provides commands to list services, show details, find providers, and visualize dependencies.

## Features

- `:ListServices` — Lists all available services.
- `:ShowService <service_name>` — Shows inputs and outputs for a service.
- `:GetProvider` — When cursor is on an input field, shows which service provides it.
- `:DrawDependencies` — ASCII graph of a service's inputs/outputs and connections.

## Setup

1. Place `lua/service_explorer/init.lua` in your project.
2. Add to your Neovim config:
   ```lua
   require("service_explorer")
   ```
3. Ensure your JSON file is at `/home/joel.nordh/work/seedhawk/SeedHawkGateway.json`.

## Extending

- Add new commands by editing `init.lua` and using `vim.api.nvim_create_user_command`.
- Change the JSON path by modifying `json_path` in `init.lua`.
- Enhance output formatting using Neovim's floating windows or buffers.
- Integrate with Telescope or other UI plugins for richer interaction.

## Contributing

- Fork and submit PRs for new features.
- File issues for bugs or suggestions.

## License

MIT
