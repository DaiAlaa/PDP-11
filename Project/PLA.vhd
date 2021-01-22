Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity PLA is 
	port( IR,Flag : in std_logic_vector (15 downto 0) ;BitOring : IN std_logic_vector (2 downto 0); En,RST,clk : in std_logic ; uPCOUT : OUT std_logic_vector (8 DOWNTO 0) );
end entity;

Architecture pla OF PLA IS 
	
    SIGNAL uPC : std_logic_vector(8 DOWNTO 0) := "000000000" ;
    SIGNAL Temp : std_logic_vector(8 DOWNTO 0) := "000000000" ;
   

BEGIN    
     PROCESS(En,clk) IS 
   
        BEGIN
            IF RST = '1' THEN
                Temp <= "000000000"; 
                uPC <=Temp;
            ELSIF En= '1' THEN
                IF BitOring( 2 downto 0) = "101" THEN
                        Temp <= "000000000"; 
                        uPC <=Temp;
                ELSIF ((IR(15 DownTo 12) = "1000" OR (not IR(15)) ='1') AND BitOring(2 DownTo 0) = "000") THEN        --Two Operand -> Fetch Source
                    IF IR(11 DOWNTO 9) = "000" THEN
                        Temp <=  "001000001";
                        uPc <= Temp;   
                    ELSIF IR(11 DOWNTO 9) = "001" OR IR(11 DOWNTO 9) = "101" THEN
                        Temp <=  "001010001";
                        uPc <= Temp; 
                    ELSIF IR(11 DOWNTO 9) = "010" OR IR(11 DOWNTO 9) = "110" THEN
                        Temp <=  "001100001";
                        uPc <= Temp; 
                    ELSIF IR(11 DOWNTO 9) = "011" OR IR(11 DOWNTO 9) = "111" THEN
                        Temp <=  "001110001";
                        uPc <= Temp; 
                    ELSIF IR(11 DOWNTO 9) = "100" THEN
                        Temp <=  "001001001";
                        uPc <= Temp;      
                    END IF;   

                ELSIF BitOring(2 DownTo 0) = "001" THEN
                    IF IR(5 DownTo 3) = "000" THEN
                        Temp <=  "010000001";
                        uPc <= Temp;
                    ELSIF IR(5 DownTo 3) = "001" OR IR(5 DownTo 3) = "101" THEN
                        Temp <=  "010010001";
                        uPc <= Temp; 
                    ELSIF IR(5 DownTo 3) = "010" OR IR(5 DownTo 3) = "110" THEN
                        Temp <=  "010100001";
                        uPc <= Temp; 
                    ELSIF IR(5 DownTo 3) = "011" OR IR(5 DownTo 3) = "111" THEN
                        Temp <=  "010110001";
                        uPc <= Temp; 
                    ELSIF IR(5 DownTo 3) = "100" THEN
                        Temp <=  "010001001";
                        uPc <= Temp; 
                END IF;    

                ElSIF ((IR(15)='1' AND (not IR(14)) ='1') AND BitOring(2 DownTo 0) = "000" ) THEN        --One Operand -> Fetch Destination
                    IF IR(5 DownTo 3) = "000" THEN
                        Temp <=  "010000001";
                        uPc <= Temp;
                    ELSIF IR(5 DownTo 3) = "001" OR IR(5 DownTo 3) = "101" THEN
                        Temp <=  "010010001";
                        uPc <= Temp; 
                    ELSIF IR(5 DownTo 3) = "010" OR IR(5 DownTo 3) = "110" THEN
                        Temp <=  "010100001";
                        uPc <= Temp; 
                    ELSIF IR(5 DownTo 3) = "011" OR IR(5 DownTo 3) = "111" THEN
                        Temp <=  "010110001";
                        uPc <= Temp; 
                    ELSIF IR(5 DownTo 3) = "100" THEN
                        Temp <=  "010001001";
                        uPc <= Temp; 
                    END IF;                   


                ElSIF (IR(15)='1' AND IR(14) ='1' And (not IR(13)) ='1') THEN        --Branching -> Fetch Offset
                    IF IR(15 DOWNTO 10) = "110000"   THEN                                      --BR            
                        Temp <=  "000100000";
                        uPc <= Temp;                                      
                    ELSIF IR(15 DOWNTO 10) = "110001" AND Flag(1) ='1' THEN                    --BEQ
                        Temp <=  "000100000";
                        uPc <= Temp;  
                    ELSIF IR(15 DOWNTO 10) = "110010" AND Flag(1) ='0'  THEN                   --BNE
                        Temp <=  "000100000";
                        uPc <= Temp;  
                    ELSIF IR(15 DOWNTO 10) = "110011" AND Flag(0) ='0'  THEN                   --BLO
                        Temp <=  "000100000";
                        uPc <= Temp;  
                    ELSIF IR(15 DOWNTO 10) = "110100" AND (Flag(0) ='0' OR Flag(1)='1') THEN   --BLS
                        Temp <=  "000100000";
                        uPc <= Temp;  
                    ELSIF IR(15 DOWNTO 10) = "110001" AND Flag(0) ='1'   THEN                  --BHI
                        Temp <=  "000100000";
                        uPc <= Temp;  
                    ELSIF IR(15 DOWNTO 10) = "110001" AND (Flag(0) ='1' OR Flag(1)='1')  THEN  --BHS
                        Temp <=  "000100000";
                        uPc <= Temp;  
                    ELSE 
                        Temp <= "000000000"; 
                        uPC <=Temp;      
                    END IF;

                ElSIF (IR(15 DownTo 10) ="111000") THEN        --HLT
                    Temp <=  "000100101";
                    uPc <= Temp; 
                ElSIF (IR(15 DownTo 10) ="111001") THEN        --NOP
                    Temp <=  "000100100";
                    uPc <= Temp;   
                ElSIF (IR(15 DownTo 10) ="111100") THEN        --JSR
                    Temp <=  "011010001";
                    uPc <= Temp;  
                ElSIF (IR(15 DownTo 10) ="111101") THEN        --RTS
                    Temp <=  "011011010";
                    uPc <= Temp;  
                ElSIF (IR(15 DownTo 10) ="111110") THEN        --INT
                    Temp <=  "000100111";
                    uPc <= Temp;  
                ElSIF (IR(15 DownTo 10) ="111111") THEN        --RET
                    Temp <=  "000110001";
                    uPc <= Temp;  
                ElSIF (BitOring(2 DownTo 0) ="010") THEN        --Or Indirect Source
                    IF IR(11 DOWNTO 9) ="000" THEN
                        Temp <=  "010000000";
                        uPc <= Temp; 
                    ElSIF IR(11) ='1' THEN
                        Temp <=  "001111000";
                        uPc <= Temp; 
                    ELSIF IR(11) ='0' THEN   
                        Temp <=  "001111001";
                        uPc <= Temp;   
                    END IF;  
                ElSIF (BitOring(2 DownTo 0) ="011") THEN        --Or Indirect Destination
                    IF IR(5 DOWNTO 3) ="000" THEN
                        Temp <=  "100110111";
                        uPc <= Temp; 
                    ElSIF IR(5) ='1' THEN
                        Temp <=  "010111000";
                        uPc <= Temp; 
                    ELSIF IR(5) ='0' THEN   
                        Temp <=  "010111001";
                        uPc <= Temp;   
                    END IF; 
                ElSIF (BitOring(2 DownTo 0) ="100") AND ((uPC ="010111010") OR (uPC ="100110111")) THEN        --Or Result -> Fetch instruction
                    IF (IR(15 DownTo 12) = "1000" OR  IR(15)='0') THEN           --Two Operands
                        IF IR(15 DownTo 12) = "0000" THEN      --MOV            
                            Temp <=  "100111000";
                            uPc <= Temp; 
                        ELSIF IR(15 DownTo 12) = "0001" THEN      --ADD  
			
                            Temp <=  "100111010";
                            uPc <= Temp; 
                        ELSIF IR(15 DownTo 12) = "0010" THEN      --ADC        
                            Temp <=  "100111100";
                            uPc <= Temp;     
                        ELSIF IR(15 DownTo 12) = "0011" THEN      --SUB        
                            Temp <=  "100111110";
                            uPc <= Temp;     
                        ELSIF IR(15 DownTo 12) = "0100" THEN      --SBC        
                            Temp <=  "101000000";
                            uPc <= Temp;     
                        ELSIF IR(15 DownTo 12) = "0101" THEN      --AND        
                            Temp <=  "101000010";
                            uPc <= Temp;   
                        ELSIF IR(15 DownTo 12) = "0110" THEN      --OR        
                            Temp <=  "101000100";
                            uPc <= Temp;      
                        ELSIF IR(15 DownTo 12) = "0111" THEN      --XOR        
                            Temp <=  "101000110";
                            uPc <= Temp;    
                        ELSIF IR(15 DownTo 12) = "1000" THEN      --CMP        
                            Temp <=  "101001000";
                            uPc <= Temp;    
                        END IF;
                    ELSE
                        IF IR(15 DownTo 10) = "100100" THEN          --INC
                            Temp <=  "101001010";
                            uPc <= Temp; 
                        ELSIF IR(15 DownTo 10) = "100101" THEN       --DEC
                            Temp <=  "101001100";
                            uPc <= Temp; 
                        ELSIF IR(15 DownTo 10) = "100110" THEN       --CLR
                            Temp <=  "101001110";
                            uPc <= Temp;    
                        ELSIF IR(15 DownTo 10) = "100111" THEN       --INV
                            Temp <=  "101010000";
                            uPc <= Temp;   
                        ELSIF IR(15 DownTo 10) = "101000" THEN       --LSR
                            Temp <=  "101010010";
                            uPc <= Temp;  
                        ELSIF IR(15 DownTo 10) = "101001" THEN       --ROR
                            Temp <=  "101010100";
                            uPc <= Temp;  
                        ELSIF IR(15 DownTo 10) = "101010" THEN       --ASR
                            Temp <=  "101010110";
                            uPc <= Temp;  
                        ELSIF IR(15 DownTo 10) = "101011" THEN       --LSL
                            Temp <=  "101011000";
                            uPc <= Temp;  
                        ELSIF IR(15 DownTo 10) = "101100" THEN       --ROL
                            Temp <=  "101011010";
                            uPc <= Temp;
                        ELSIF (IR(15 DownTo 10) = "111000") THEN    -- ->HLT
                            Temp <=  "000100101";
                            uPc <= Temp;
                        ELSIF (IR(15 DownTo 10) = "111001") THEN    --  ->NOP
                            Temp <=  "000100100";
                            uPc <= Temp;
                        ELSIF (IR(15 DownTo 10) = "111100") THEN    --  ->JSR
                            Temp <=  "011010001";
                            uPc <= Temp;
                        ELSIF (IR(15 DownTo 10) = "111101") THEN    --  ->RTS
                            Temp <=  "011011010";
                            uPc <= Temp;
                        ELSIF (IR(15 DownTo 10) = "111110") THEN    --  ->INT
                            Temp <=  "000100111";
                            uPc <= Temp;   
                        ELSIF (IR(15 DownTo 10) = "111111") THEN    --  ->IRET
                            Temp <=  "000110001";
                            uPc <= Temp;                                                                                                                                           
                        END IF;
                    END IF;   
                ELSIF BitOring(2 DownTo 0) = "100" THEN
                    IF IR (5 DownTo 3) ="000" THEN
                        Temp <=  "101100101";
                        uPc <= Temp;  
                    ELSE
                        Temp <=  "101100111";
                        uPc <= Temp;   
                    END IF;  
                
                END IF;     
            ELSIF falling_edge(clk) THEN
                Temp <= "000000000";      
                uPC <= std_logic_vector(unsigned(uPC)+1);    
            END IF;    
        uPCOUT <= uPC;    
        END PROCESS;
end Architecture;
