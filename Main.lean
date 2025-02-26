import Init.Data.ByteArray
import Hakken

def main : IO Unit :=
  let hello_world := "Hello, World!"
  IO.println hello_world


def read_file_to_base64 (filename : String) : IO String := do
  let hd <- IO.FS.Handle.mk (System.FilePath.mk filename) IO.FS.Mode.read
  return ""
