return {
	"mfussenegger/nvim-jdtls",
	dependencies = { "neovim/nvim-lspconfig" },
	ft = { "java" },
	config = function()
		-- This will be called when a Java file is opened
		local jdtls = require("jdtls")

		-- Setup JDTLS configuration
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				-- Get the root directory of the project
				local root_dir =
					require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

				local config = {
					cmd = {
						"java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-Xmx1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						"-jar",
						vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
						"-configuration",
						vim.fn.expand("$MASON/share/jdtls/config_linux"), -- Adjust based on OS
						"-data",
						vim.fn.expand("~/.cache/jdtls-workspace/") .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
					},
					root_dir = root_dir,
					settings = {
						java = {
							signatureHelp = { enabled = true },
							contentProvider = { preferred = "fernflower" },
							completion = {
								favoriteStaticMembers = {
									"org.junit.Assert.*",
									"org.junit.Assume.*",
									"org.junit.jupiter.api.Assertions.*",
									"java.util.Objects.requireNonNull",
									"java.util.Objects.requireNonNullElse",
								},
								filteredTypes = {
									"com.sun.*",
									"io.micrometer.shaded.*",
									"java.awt.*",
									"jdk.*",
									"sun.*",
								},
							},
							sources = {
								organizeImports = {
									starThreshold = 9999,
									staticStarThreshold = 9999,
								},
							},
							codeGeneration = {
								toString = {
									template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
								},
								useBlocks = true,
							},
						},
					},
					init_options = {
						bundles = {},
					},
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				}

				-- Start the language server
				require("jdtls").start_or_attach(config)
			end,
		})
	end,
}
