#Requires AutoHotkey v2.0
TraySetIcon("UnicodeGUI_GUI.png")

RCtrl:: Return ; Disable RCtrl by itself
#HotIf (GetKeyState("RCtrl", "P") == 0) ; None
    <^>!+é::Send("{U+00C9}") ; AltGr + Shift + é -> É (E Acute)
    <^>!+à::Send("{U+00C0}") ; AltGr + Shift + à -> À (A Grave)
    <^>!+è::Send("{U+00C8}") ; AltGr + Shift + è -> È (E Grave)
    <^>!+ù::Send("{U+00D9}") ; AltGr + Shift + ù -> Ù (U Grave)
    <^>!+ç::Send("{U+00C7}") ; AltGr + Shift + ç -> Ç (C Cedilla)
    <^>!o::Send("{U+0153}") ; AltGr + o -> œ (OE Ligature)
    <^>!+o::Send("{U+0152}") ; AltGr + Shift + o -> Œ (OE Ligature Capital)

    ; Coherent replacement
    <^>!+-::Send("{U+FF5C}") ; AltGr + Alt + - (|) -> ｜ (Fullwidth Vertical Line)
    <^>!+,::Send("{U+FF1F}") ; AltGr + Shift + , (?) -> ？ (Fullwidth Question Mark)
    ; <^>!;::Send("") ; AltGr + ;
    <^>!SC034::Send("{U+FF1A}") ; AltGr + : ->： (Fullwidth Colon)  
    <^>!+SC034::Send("{U+FF0F}") ; AltGr + Shift + : (/) -> ／ (Fullwidth Slash)
    <^>!*::Send("{U+FF0A}") ; AltGr + * -> ＊ (Fullwidth Asterisk)
    <^>!+_::Send("{U+FF3C}") ; AltGr + Shift + _ (\) -> ＼ (Fullwidth Backslash)
    <^>!<::Send("{U+FF1C}") ; AltGr + < -> ＜ (Fullwidth Less-Than Sign)
    <^>!+<::Send("{U+FF1E}") ; AltGr + Shift + < (>) -> ＞ (Fullwidth Greater-Than Sign)

    ; Hazardous replacements
    <^>!+'::Send("{U+2014}") ; AltGr + Shift + - -> — (Em Dash)
    <^>!+(::Send("{U+300C}") ; AltGr + Shift + ( -> 「 (Left Corner Bracket)
    <^>!+)::Send("{U+300D}") ; AltGr + Shift + ) -> 」 (Right Corner Bracket)
    
    


#HotIf (GetKeyState("RCtrl", "P") == 1) ; AppsKey
    ; == Greek alphabet ==
    a::Send("{U+0251}") ; AppsKey + a -> α (Alpha)
    +a::Send("{U+0391}") ; AppsKey + Shift + a -> Α (Alpha Capital)
    z::Send("{U+03B6}") ; AppsKey + z -> ζ (Zeta)
    +z::Send("{U+0396}") ; AppsKey + Shift + z -> Ζ (Zeta Capital)
    e::Send("{U+03B5}") ; AppsKey + e -> ε (Epsilon)
    +e::Send("{U+0395}") ; AppsKey + Shift + e -> Ε (Epsilon Capital)
    r::Send("{U+03C1}") ; AppsKey + r -> ρ (Rho)
    +r::Send("{U+03A1}") ; AppsKey + Shift + r -> Ρ (Rho Capital)
    t::Send("{U+03C4}") ; AppsKey + t -> τ (Tau)
    +t::Send("{U+03A4}") ; AppsKey + Shift + t -> Τ (Tau Capital)
    y::Send("{U+03C8}") ; AppsKey + y -> ψ (Psi)
    +y::Send("{U+03A8}") ; AppsKey + Shift + y -> Ψ (Psi Capital)
    u::Send("{U+03C5}") ; AppsKey + u -> υ (Upsilon)
    +u::Send("{U+03A5}") ; AppsKey + Shift + u -> Υ (Upsilon Capital)
    i::Send("{U+03B9}") ; AppsKey + i -> ι (Iota)
    +i::Send("{U+0399}") ; AppsKey + Shift + i -> Ι (Iota Capital)
    o::Send("{U+03BF}") ; AppsKey + o -> ο (Omicron)
    +o::Send("{U+039F}") ; AppsKey + Shift + o -> Ο (Omicron Capital)
    p::Send("{U+03C0}") ; AppsKey + p -> π (Pi)
    +p::Send("{U+03A0}") ; AppsKey + Shift + p -> Π (Pi Capital)

    q::Send("{U+03BE}") ; AppsKey + q -> ξ (Xi)
    +q::Send("{U+039E}") ; AppsKey + Shift + q -> Ξ (Xi Capital)
    s::Send("{U+03C3}") ; AppsKey + s -> σ (Sigma)
    +s::Send("{U+03A3}") ; AppsKey + Shift + s -> Σ (Sigma Capital)
    ; Hotkey("~<^>!s", SendSigmaFinal) ; TODO: not working
    ; SendSigmaFinal(ThisKey) {
    ;     if (GetKeyState("RCtrl", "P") == 1){ 
    ;         Send("{U+03C2}") ; AppsKey + AltGr + s -> ς (Sigma Final)
    ;     }
    ; }
    
    d::Send("{U+03B4}") ; AppsKey + d -> δ (Delta)
    +d::Send("{U+0394}") ; AppsKey + Shift + d -> Δ (Delta Capital)
    f::Send("{U+03C6}") ; AppsKey + f -> φ (Phi)
    +f::Send("{U+03A6}") ; AppsKey + Shift + f -> Φ (Phi Capital)
    g::Send("{U+03B3}") ; AppsKey + g -> γ (Gamma)
    +g::Send("{U+0393}") ; AppsKey + Shift + g -> Γ (Gamma Capital)
    h::Send("{U+03B7}") ; AppsKey + h -> η (Eta)
    +h::Send("{U+0397}") ; AppsKey + Shift + h -> Η (Eta Capital)
    j::Send("{U+03B8}") ; AppsKey + j -> θ (Theta)
    +j::Send("{U+0398}") ; AppsKey + Shift + j -> Θ (Theta Capital)
    k::Send("{U+03BA}") ; AppsKey + k -> κ (Kappa)
    +k::Send("{U+039A}") ; AppsKey + Shift + k -> Κ (Kappa Capital)
    l::Send("{U+03BB}") ; AppsKey + l -> λ (Lambda)
    +l::Send("{U+039B}") ; AppsKey + Shift + l -> Λ (Lambda Capital)
    m::Send("{U+03BC}") ; AppsKey + m -> μ (Mu)
    +m::Send("{U+039C}") ; AppsKey + Shift + m -> Μ (Mu Capital)

    w::Send("{U+03C9}") ; AppsKey + w -> ω (Omega)
    +w::Send("{U+03A9}") ; AppsKey + Shift + w -> Ω (Omega Capital)
    x::Send("{U+03C7}") ; AppsKey + x -> χ (Chi)
    +x::Send("{U+03A7}") ; AppsKey + Shift + x -> Χ (Chi Capital)
    ; c::Send("{U+03C8}") ; 
    ; +c::Send("{U+03A8}") ;
    v::Send("{U+03BD}") ; AppsKey + v -> ν (Nu)
    +v::Send("{U+039D}") ; AppsKey + Shift + v -> Ν (Nu Capital)
    b::Send("{U+03B2}") ; AppsKey + b -> β (Beta)
    +b::Send("{U+0392}") ; AppsKey + Shift + b -> Β (Beta Capital)
    ; n::Send("{U+03BD}") ;
    ; +n::Send("{U+039D}") ;

    n::Send("{U+00F1}") ; AppsKey + n -> ñ (N Tilde)
    +n::Send("{U+00D1}") ; AppsKey + Shift + n -> Ñ (N Tilde Capital)

    
; ==== Misc ====
#HotIf (GetKeyState("RCtrl", "P") == 0) ; None
    +SC029::Send("{U+221A}") ; Shift + ² -> √ (Square Root)
    <^>!+=::Send("{U+00B1}") ; AltGr + = -> ± (Plus-Minus Sign)
    <^>!+*::Send("{U+00D7}") ; AltGr + Shift + * -> × (Multiplication Sign)
    <^>!SC029::Send("{U+2208}") ; AltGr + ³ -> ∈ (Element Of)
    <^>!+SC029::Send("{U+2209}") ; AltGr + 4 -> ∉ (Not An Element Of)

    ; +²::Send("")
#HotIf (GetKeyState("RCtrl", "P") == 1) ; AppsKey
    =::Send("{U+2260}") ; AppsKey + = -> ≠ (Not Equal To)
    é::Send("{U+301C}") ; AppsKey + é -> 〜 (Wave Dash)
    $::Send("{U+00A5}") ; AppsKey + $ -> ¥ (Yen Sign)
    
    SC029::Send("{U+2200}") ; AppsKey + ² -> ∀ (For All)
    +SC029::Send("{U+2203}") ; AppsKey + ³ -> ∃ (There Exists)

    <::Send("{U+2264}") ; AppsKey + < -> ≤ (Less-Than Or Equal To)
    +<::Send("{U+2265}") ; AppsKey + Shift + < -> ≥ (Greater-Than Or Equal To)

    Up::Send("{U+2191}") ; AppsKey + Up -> ↑ (Upwards Arrow)
    Down::Send("{U+2193}") ; AppsKey + Down -> ↓ (Downwards Arrow)
    Left::Send("{U+2190}") ; AppsKey + Left -> ← (Leftwards Arrow)
    Right::Send("{U+2192}") ; AppsKey + Right -> → (Rightwards Arrow)
    +Up::Send("{U+21D1}") ; AppsKey + Shift + Up -> ⇑ (Upwards Double Arrow)
    +Down::Send("{U+21D3}") ; AppsKey + Shift + Down -> ⇓ (Downwards Double Arrow)
    +Left::Send("{U+21D0}") ; AppsKey + Shift + Left -> ⇐ (Leftwards Double Arrow)
    +Right::Send("{U+21D2}") ; AppsKey + Shift + Right -> ⇒ (Rightwards Double Arrow)
    <^>!Up::Send("{U+2195}") ; AppsKey + AltGr + Up -> ↕ (Up Down Arrow)
    <^>!Down::Send("{U+2194}") ; AppsKey + AltGr + Down -> ↔ (Left Right Arrow)
    <^>!+Up::Send("{U+21D5}") ; AppsKey + AltGr + Shift + Up -> ⇕ (Up Down Double Arrow)
    <^>!+Down::Send("{U+21D4}") ; AppsKey + AltGr + Shift + Down -> ⇔ (Left Right Double Arrow)

    ; = AltGr + Shift =
    <^>!+=::Send("{U+2213}") ; AppsKey + AltGr + = -> ∓ (Minus-Or-Plus Sign)
    <^>!+n::Send("{U+2115}") ; AppsKey + AltGr + n -> ℕ (Double-Struck Capital N)
    <^>!+z::Send("{U+2124}") ; AppsKey + AltGr + z -> ℤ (Double-Struck Capital Z)
    <^>!+q::Send("{U+211A}") ; AppsKey + AltGr + q -> ℚ (Double-Struck Capital Q)
    <^>!+r::Send("{U+211D}") ; AppsKey + AltGr + r -> ℝ (Double-Struck Capital R)
    <^>!+c::Send("{U+2102}") ; AppsKey + AltGr + c -> ℂ (Double-Struck Capital C)
    <^>!+p::Send("{U+2119}") ; AppsKey + AltGr + p -> ℙ (Double-Struck Capital P)
    <^>!+h::Send("{U+210D}") ; AppsKey + AltGr + h -> ℍ (Double-Struck Capital H)
    <^>!+m::Send("{U+2133}") ; AppsKey + AltGr + m -> ℳ (Script Capital M)

    <^>!<::Send("{U+00AB}") ; AppsKey + < -> « (Left Double Angle Quote)
    <^>!+<::Send("{U+00BB}") ; AppsKey + Shift + < -> » (Right Double Angle Quote)