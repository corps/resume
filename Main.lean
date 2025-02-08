import Init.Data.ByteArray
import Parser
import Mathlib

def main : IO Unit :=
  let hello_world := "Hello, World!"
  IO.println hello_world


def read_file_to_base64 (filename : String) : IO String := do
  let hd <- IO.FS.Handle.mk (System.FilePath.mk filename) IO.FS.Mode.read
  return ""

namespace B64

private def base64Alphabet : Vector Char 64 :=
  #v['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
   'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
   'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
   'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/']

def bit_split (data: Vector (BitVec β) τ) : List (BitVec α) :=
  if h: τ * β = 0 ∨ α = 0 then []
  else
    let χ := min α β
    let h₁ : α > 0 := Nat.pos_of_ne_zero (not_or.mp h).right
    let h₂ : β > 0 := by 
      have : τ * β > 0 := Nat.pos_of_ne_zero (not_or.mp h).left
      exact Nat.pos_of_mul_pos_left this
    let h₃ : τ > 0 := by
      have : τ * β > 0 := Nat.pos_of_ne_zero (not_or.mp h).left
      rw [Nat.mul_comm] at this
      exact Nat.pos_of_mul_pos_left this

    let rec collect (pos: Fin χ × Fin τ) (result: List (BitVec α)) : List (BitVec α) :=
      []
    collect ((Fin.mk 0 (lt_min h₁ h₂)), (Fin.mk 0 h₃)) []

end B64
