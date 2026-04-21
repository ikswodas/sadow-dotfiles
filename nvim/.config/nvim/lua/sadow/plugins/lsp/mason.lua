return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"html", -- For HTML projects
				"clangd", -- For C Projects
				"lua_ls", -- For Lua projects
				"pyright", -- For Python projects
				"kotlin_language_server",
				"jdtls", -- Java language server with more features
				"gradle_ls", -- For Gradle build files
				"lemminx", -- For XML files
				"vtsls", -- TypeScript/JavaScript LSP
				"tailwindcss", -- Tailwind/NativeWind
				"jsonls", -- JSON/JSONC with schema support
				"yamlls", -- YAML with GitHub Actions schema support
				"bashls", -- Bash LSP
				"sqls", -- SQL LSP
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"eslint_d",
				"ktlint", -- kotlin formatter
				"google-java-format", -- Java formatter
				"checkstyle", -- Java code quality checker
				"pylint",
				"shellcheck", -- Bash linter
				"shfmt", -- Bash formatter
				"sqlfluff", -- SQL linter/formatter (use --dialect postgres)
			},
		})
	end,
}
