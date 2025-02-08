import Lake
open Lake DSL

package «resume» where
  -- Settings applied to both builds and interactive editing
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩ -- pretty-prints `fun a ↦ b`
  ]
  -- add any additional package configuration options here

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

require Parser from git
  "https://github.com/fgdorais/lean4-parser" @ "main"

lean_lib «Resume» where
  -- add any library configuration options here

@[default_target]
lean_exe «resume» where
  root := `Main
