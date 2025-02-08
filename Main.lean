import Init.Data.ByteArray
import Parser
import Mathlib

def main : IO Unit :=
  let hello_world := "Hello, World!"
  IO.println hello_world


def read_file_to_base64 (filename : String) : IO String := do
  let hd <- IO.FS.Handle.mk (System.FilePath.mk filename) IO.FS.Mode.read
  return ""
  -- let base64_content := Base64.encode file_content
  -- base64_content

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
    let h₂ : β > 0 := Nat.pos_of_ne_zero 
      -- apply (Nat.eq_zero_or_pos β).resolve_left
      -- intro a
      -- rw [a] at h
      -- exact False.elim $ (not_or.mp h).left (mul_zero τ)
    let h₃ : τ > 0 := by
      apply (Nat.eq_zero_or_pos τ).resolve_left
      intro a
      rw [a] at h
      exact False.elim $ (not_or.mp h).left (zero_mul β)

    let rec collect (pos: Fin χ × Fin τ) (result: List (BitVec α)) : List (BitVec α) :=
      []
    collect (Fin.mk 0 (h))
    -- collect (Fin.mk 0 (by
    --   have : χ = min α β := rfl
    --   rw [this]
    --   apply Nat.le_min_of_le_of_le

    -- ), Fin.mk 0 (simp)) []


    -- let rec split (pos: (Fin α) × ℕ) (h: pos.1 < α) (buf: BitVec (pos.1)) (result: List (BitVec α)) : List (BitVec α) :=
    --   if pos.1 < α then
    --     []
    --   else
    --     result
    -- split (0, 0) []


-- inductive Alignment (α: ℕ) (β: ℕ) (σ: ℕ) : ℕ -> Type where
--   | head : α > 0 ∧ β > 0 ∧ σ > 0 -> Alignment α β σ 0
--   | read : Alignment α β σ τ ->

-- inductive TokenToByteAlignment (tokenSize: Nat) : Nat -> Fin tokenSize -> Type where
--   | tail : (unused: Fin tokenSize) -> TokenAlignment tokenSize 1 unused

-- inductive ByteAlignedTokenizer : Nat -> Type where
--   | padding : (b: Nat) -> ByteAlignedTokenizer $ b


-- #check (WordTokenizer.body $ WordTokenizer.head (by simp) : WordTokenizer ({ tokenBits = 6, wordBytes = 4}))


#check 4 / 7

abbrev Pos := Nat × Nat
-- def takeToken (t: BitVecTokenizer) : StateRef Pos (Fin $ 2 ^ t.tokenBits) :=


#check ReaderT
#check Parser

def encode (bytes: ByteArray) : String :=
  let rec encode_ (bytes: Batteries.ByteSubarray) (result: String) : String :=
    match Stream.next? bytes with
    | none => result
    | some (b1, bytes) => match Stream.next? bytes with
      | none =>
        let b1 := b1.toBitVec
        String.append result $ String.mk [
          (base64Alphabet.get (Fin.mk (b1.toNat / 4) (by
            have h : 4 ∣ 256 := Nat.dvd_mul_right 4 64
            calc
              b1.toNat / 4 < 256 / 4 := Nat.div_lt_div_of_lt_of_dvd h b1.isLt
              _ = 64 := by simp
           )))
        ]
      | some (b2, bytes) => result
  encode_ bytes ""

-- def read_file_to_base64 (filename : String) : IO String :=
--   IO.FS.readFile filename >>= fun file_content =>
--     return base64Encode file_content

end B64
