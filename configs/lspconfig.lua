local project_dir   = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls-workspace/') .. project_dir
local jdt_home      = os.getenv('JDT_HOME')
local jdt_jar       = io.popen('find ' .. jdt_home .. '/plugins -name "org.eclipse.equinox.launcher_*.jar"'):read('*a')
local on_attach     = require('plugins.configs.lspconfig').on_attach
local capabilities  = require('plugins.configs.lspconfig').capabilities
local lspconfig     = require('lspconfig')

local function what_os()
  local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
  if BinaryFormat == "dll" then
    return "win"
  elseif BinaryFormat == "so" then
    return "linux"
  elseif BinaryFormat == "dylib" then
    return "mac"
  end
end

local os_type = what_os()


lspconfig.jdtls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function()
    return require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' })
  end,
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', jdt_jar,
    '-configuration', jdt_home .. '/config_' .. os_type,
    '-data', workspace_dir,
  },
})

