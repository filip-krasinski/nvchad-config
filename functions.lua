local M = {}

function M.what_os()
  local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
  if BinaryFormat == "dll" then
    return "win"
  elseif BinaryFormat == "so" then
    return "linux"
  elseif BinaryFormat == "dylib" then
    return "mac"
  end
end

return M
