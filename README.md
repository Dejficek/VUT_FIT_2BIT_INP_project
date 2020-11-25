# VUT_FIT_2BIT_INP_project
V jazyce VHDL pops8n a do
binárního řetězce pro FPGA syntetizován obvod realizující lehce
modifikovaný algoritmus Vigenèrovy šifry. Vigenèrova šifra patří
do kategorie substitučních šifer a její princip pro potřeby tohoto
projektu bude spočívat v nahrazování každého znaku zprávy znakem,
který je v abecedě posunut o hodnotu danou příslušným znakem
šifrovacího klíče. Uvažujte zprávu tvořenou velkými písmeny
anglické abecedy A-Z (tj. pouze znaky bez diakritiky, CH je bráno
jako dva samostatné znaky) a číslicemi 0-9. Šifrovací klíč o pevné
délce dvou znaků bude tvořen písmeny anglické abecedy A-Z
a periodicky se opakuje přes všechny znaky zprávy. Znaky budou pro
potřeby šifrování reprezentovány svými ASCII kódy. Šifrování
probíhá tak, že první znak klíče posouvá znak zprávy vpřed, druhý
znak klíče posouvá znak zprávy vzad, číslice jsou nahrazovány
znakem #. Pokud vychází posuv před písmeno A nebo za písmeno Z,
uvažuje se cyklicky z opačného konce abecedy – viz příklad.

Příklad: zpráva XBIDLO01, klíč BI (B posouvá o 2 znaky vpřed,
I posouvá o 9 znaků vzad). Postup šifrování:

zpráva: ```X B I D L O 0 1```\
klíč:   ```B I B I B I B I```\
posuv:  ```+2 -9 +2 -9 +2 -9 +2 -9```\
 -----------------------
        ```Z S K U N F # #``` ← zašifrovaný text
