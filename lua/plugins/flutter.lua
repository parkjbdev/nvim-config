-- local dap = require("dap")
--
-- dap.set_log_level("TRACE")
-- dap.adapters.dart = {
--   type = "executable",
--   command = "dart",
--   -- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
--   args = { "debug_adapter" },
-- }

-- dap.adapters.dart = {
--   type = "executable",
--   -- As of this writing, this functionality is open for review in https://github.com/flutter/flutter/pull/91802
--   command = "flutter",
--   args = { "debug-adapter" },
-- }
-- dap.configurations.dart = {
  -- {
  --   type = "dart",
  --   request = "launch",
  --   name = "Launch Dart Program",
  --   -- The nvim-dap plugin populates this variable with the filename of the current buffer
  --   program = "${file}",
  --   -- The nvim-dap plugin populates this variable with the editor's current working directory
  --   cwd = "${workspaceFolder}",
  --   args = { "--help" }, -- Note for Dart apps this is args, for Flutter apps toolArgs
  -- },
  -- {
  --   type = "dart",
  --   request = "launch",
  --   name = "Launch Flutter",
  --   -- The nvim-dap plugin populates this variable with the filename of the current buffer
  --   program = "${file}",
  --   -- program = os.execute([[echo "$(brew --caskroom flutter)/$(brew list --versions --casks flutter | tr ' ' '\n' | tail -1)/flutter"]]),
  --   -- The nvim-dap plugin populates this variable with the editor's current working directory
  --   cwd = "${workspaceFolder}",
  --   -- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
  --   toolArgs = { "-d", "linux" },
  -- },
-- }
--
return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
    debugger = { -- integrate with nvim dap + install dart code debugger
      enabled = true,
      run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
      -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
      -- see |:help dap.set_exception_breakpoints()| for more info
      exception_breakpoints = {},
      register_configurations = function(paths)
        local dap = require("dap")

        dap.set_log_level("TRACE")
        dap.adapters.dart = {
          type = "executable",
          command = "dart",
          -- This command was introduced upstream in https://github.com/dart-lang/sdk/commit/b68ccc9a
          args = { "debug_adapter" },
        }
        require("dap").configurations.dart = {
          -- <put here config that you would find in .vscode/launch.json>
        }
      end,
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "sidlatau/neotest-dart" },
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require("neotest-dart")({ command = "flutter" }),
      })
    end,
  },
}
