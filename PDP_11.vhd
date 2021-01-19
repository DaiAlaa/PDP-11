Library ieee;
use ieee.std_logic_1164.all;

entity PDP_11 is 
GENERIC ( n : integer := 16);
	port( 
	      Clk : IN std_logic;
              Rst : IN std_logic; 
              outbus : inout std_logic_vector (n-1 downto 0));
end entity;

Architecture my_PDP_11 OF PDP_11 IS

	COMPONENT decoder IS
        GENERIC ( n : integer := 2);
	port( E : in std_logic;
              sel : in std_logic_vector (n-1 downto 0);
              f : out std_logic_vector (2**n-1 downto 0));
        END COMPONENT;

        COMPONENT my_nDFF IS
	GENERIC ( n : integer := 32);
	PORT( E,Clk,Rst : IN std_logic;
		   d : IN std_logic_vector(n-1 DOWNTO 0);
		   q : OUT std_logic_vector(n-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT tri_state_buffer IS
        GENERIC ( n : integer := 16);
	port( E : in std_logic;
              d : in std_logic_vector (n-1 downto 0);
              f : out std_logic_vector (n-1 downto 0));

         END COMPONENT;


         COMPONENT ram IS
         GENERIC ( n : integer := 16);
	 PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(n-1 DOWNTO 0);
		datain  : IN  std_logic_vector(n-1 DOWNTO 0);
		dataout : OUT std_logic_vector(n-1 DOWNTO 0));
         END  COMPONENT;

         COMPONENT rom IS
         GENERIC ( n : integer := 24);
	 PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(8 DOWNTO 0);
		datain  : IN  std_logic_vector(n-1 DOWNTO 0);
		dataout : OUT std_logic_vector(n-1 DOWNTO 0));
         END  COMPONENT;

         COMPONENT PLA IS
	 PORT( 
                IR,flag : in std_logic_vector (15 downto 0) ;
                BitOring : IN std_logic_vector (2 downto 0); 
                En,Rst,clk : in std_logic ;
                uPCOUT : OUT std_logic_vector (8 DOWNTO 0));
         END  COMPONENT;    

         COMPONENT Branch IS
	 PORT ( 
                IR,Flag,PCin : In std_logic_vector (15 DOWNTO 0);
                PCOut : OUT std_logic_vector (15 DOWNTO 0));
         END  COMPONENT;    

        COMPONENT MapALU IS
	 PORT ( 
                F: In std_logic_vector (4 DOWNTO 0);
                Carry,CMP : OUT std_logic ; 
                S : OUT std_logic_vector (3 DOWNTO 0));
         END  COMPONENT;   

         COMPONENT finalmux is 
	 port( 
              Cin : in std_logic;
              CmpEnable : in std_logic;
              A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              S : in std_logic_vector (3 downto 0);
              F : out std_logic_vector (15 downto 0);
              FlagRegister : out std_logic_vector (15 downto 0);
              Cout : inout std_logic;
	      CarryInput: in std_logic); 
         END  COMPONENT;   

         
	 
	 signal F1_enable: std_logic; 
	 signal F2_enable: std_logic;
	 signal F3_enable: std_logic; 
	 signal F4_enable: std_logic; 

         signal F1_output: std_logic_vector (7 downto 0);
	 signal F2_output: std_logic_vector (3 downto 0);
	 signal F3_output: std_logic_vector (3 downto 0);
	 signal F4_output: std_logic_vector (3 downto 0);
         
         signal R0: std_logic_vector (15 downto 0);
         signal R1: std_logic_vector (15 downto 0);
         signal R2: std_logic_vector (15 downto 0);
         signal R3: std_logic_vector (15 downto 0);
         signal R4: std_logic_vector (15 downto 0);
         signal R5: std_logic_vector (15 downto 0);
         signal R6: std_logic_vector (15 downto 0);
         signal R7: std_logic_vector (15 downto 0) := "0000000000000000" ;
         signal MAR: std_logic_vector (15 downto 0);
	 signal MDR: std_logic_vector (15 downto 0);
	 signal Z: std_logic_vector (15 downto 0);
         signal Y: std_logic_vector (15 downto 0);
	 signal temp: std_logic_vector (15 downto 0);
         signal flag: std_logic_vector (15 downto 0);
         signal IR: std_logic_vector (15 downto 0);
         
         signal select_enable_out : std_logic;
         signal select_src_dst_out : std_logic_vector (2 downto 0);
         signal select_register_out : std_logic_vector (7 downto 0);
         signal select_enable_in : std_logic;
         signal select_src_dst_in : std_logic_vector (2 downto 0);
         signal select_register_in : std_logic_vector (7 downto 0);

         signal MDRsignal : std_logic_vector (15 downto 0);
         signal MDRenable : std_logic;

         signal Ram_out : std_logic_vector (15 downto 0);
         signal Ram_enable : std_logic;
         signal Ram_clk : std_logic;

         signal uPC : std_logic_vector (8 downto 0);
         signal control_word : std_logic_vector (23 downto 0);
	
         signal Cin: std_logic;
         signal CMP: std_logic;
         signal S: std_logic_vector (3 downto 0);
         signal CarryOut: std_logic;
	 signal ALUOut: std_logic_vector(15 downto 0);
	 signal ALUIn: std_logic_vector(15 downto 0);
	 signal CarryInput: std_logic;
         signal Rsrc,Rdst : std_logic_vector (2 downto 0);
	 signal control: std_logic ;
	 signal controlIN: std_logic ;
	 signal yin: std_logic_vector(15 downto 0);
         
Begin
	  
         F1_enable <= '0' WHEN control_word(23 downto 21) ="000"
         ELSE '1';
         F2_enable <= '0' WHEN control_word(20 downto 19) ="00"
         ELSE '1';
         F3_enable <= '0' WHEN control_word(18 downto 17) ="00"
         ELSE '1';
         F4_enable <= '0' WHEN control_word(16 downto 15) ="00"
         ELSE '1';

         control <= '1' WHEN (F2_output(1) = '1' OR (Rsrc = "111" AND control_word(18 downto 17) ="10") OR (Rdst = "111" AND control_word(18 downto 17) ="11"))
                        ELSE '0';






         controlIN <= '1' WHEN (F1_output(1) = '1' OR (Rsrc = "111" AND control_word(23 downto 21) ="100") OR (Rdst = "111" AND control_word(23 downto 21) ="101"))
                        ELSE '0';    





         select_src_dst_out <= Rsrc WHEN control_word(23 downto 21) ="100"
                      ELSE Rdst WHEN control_word(23 downto 21) ="101"
                      ELSE (OTHERS=>'0');
         select_src_dst_in <= Rsrc WHEN control_word(18 downto 17) ="10"
                      ELSE Rdst WHEN control_word(18 downto 17) ="11"
                      ELSE (OTHERS=>'0');

         select_enable_out <= '1' WHEN control_word(23 downto 21) ="100" or control_word(23 downto 21) ="101"
                      ELSE '0';
         select_enable_in <= '1' WHEN control_word(18 downto 17) ="10" or control_word(18 downto 17) ="11"
                      ELSE '0';
         
         MDRsignal <= Ram_out WHEN control_word(7 downto 6) = "01"
                      ELSE  outbus ;

         MDRenable <= '1' WHEN control_word(7 downto 6) = "01"
                      ELSE F4_output(2) ;

         Ram_clk <= not Clk;

         Ram_enable <= '1' WHEN control_word(7 downto 6) = "10"
                     ELSE '0';





	 yin<= "000000"&IR(9 DOWNTO 0) when uPC ="000100000" else outbus;
	
         ----------------------------------------------------------------------------------
	 F1: decoder GENERIC MAP(3) port map(F1_enable,control_word(23 downto 21),F1_output); 
	 F2: decoder GENERIC MAP(2) port map(F2_enable,control_word(20 downto 19),F2_output); 
	 F3: decoder GENERIC MAP(2) port map(F3_enable,control_word(18 downto 17),F3_output); 
	 F4: decoder GENERIC MAP(2) port map(F4_enable,control_word(16 downto 15),F4_output);  
         select_reg_out : decoder GENERIC MAP(3) port map(select_enable_out,select_src_dst_out, select_register_out); 
         select_reg_in : decoder GENERIC MAP(3) port map(select_enable_in,select_src_dst_in, select_register_in); 

         ---------- F2 ---------
	 reg7: my_nDFF GENERIC MAP(16) port map(control,Clk,Rst,outbus,R7);
	 --flag_reg: my_nDFF GENERIC MAP(16) port map(F2_output(3),Clk,Rst,outbus,flag);
         IR_reg: my_nDFF GENERIC MAP(16) port map(F2_output(2),Clk,Rst,outbus,IR);
         ---------- F3 ------------
         reg0: my_nDFF GENERIC MAP(16) port map(select_register_in(0),Clk,Rst,outbus,R0);
	 reg1: my_nDFF GENERIC MAP(16) port map(select_register_in(1),Clk,Rst,outbus,R1);
	 reg2: my_nDFF GENERIC MAP(16) port map(select_register_in(2),Clk,Rst,outbus,R2);
	 reg3: my_nDFF GENERIC MAP(16) port map(select_register_in(3),Clk,Rst,outbus,R3);
         reg4: my_nDFF GENERIC MAP(16) port map(select_register_in(4),Clk,Rst,outbus,R4);
	 reg5: my_nDFF GENERIC MAP(16) port map(select_register_in(5),Clk,Rst,outbus,R5);
	 reg6: my_nDFF GENERIC MAP(16) port map(select_register_in(6),Clk,Rst,outbus,R6);
         Z_reg: my_nDFF GENERIC MAP(16) port map(F3_output(1),Clk,Rst,ALUOut,Z);
         ---------- F4 ----------
         MAR_reg: my_nDFF GENERIC MAP(16) port map(F4_output(1),Clk,Rst,outbus,MAR);
	
	 temp_reg: my_nDFF GENERIC MAP(16) port map(F4_output(3),Clk,Rst,outbus,temp);
         ----------- F5 ----------
	 Y_reg: my_nDFF GENERIC MAP(16) port map(control_word(14),Clk,Rst,yin,Y);
	 

	 tri0: tri_state_buffer port map(select_register_out(0),R0,outbus);
	 tri1: tri_state_buffer port map(select_register_out(1),R1,outbus);
	 tri2: tri_state_buffer port map(select_register_out(2),R2,outbus);
	 tri3: tri_state_buffer port map(select_register_out(3),R3,outbus);
	 tri4: tri_state_buffer port map(select_register_out(4),R4,outbus);
	 tri5: tri_state_buffer port map(select_register_out(5),R5,outbus);
	 tri6: tri_state_buffer port map(select_register_out(6),R6,outbus);
         ---------- F1 --------
	 tri7: tri_state_buffer port map(controlIN,R7,outbus);
         tri_MDR: tri_state_buffer port map(F1_output(2),MDR,outbus);
         tri_Z: tri_state_buffer port map(F1_output(3),Z,outbus);
         tri_temp: tri_state_buffer port map(F1_output(6),temp,outbus);
	 --tri_flag: tri_state_buffer port map(F1_output(7),flag,outbus);
         ----------- F6 ----------
         --tri_Y: tri_state_buffer port map(control_word(13),Y,ALUIn);

         my_ram: ram PORT MAP(Ram_clk,Ram_enable,MAR,MDR,Ram_out);              --Address Size
         my_rom: rom PORT MAP(Ram_clk,'0',uPC,(OTHERS=>'0'),control_word);              -- write enable always 0
         MDR_reg: my_nDFF GENERIC MAP(16) port map(MDRenable,Ram_clk,Rst,MDRsignal,MDR);

         my_PLA: PLA PORT MAP(IR,flag,control_word(3 downto 1),control_word(0),Rst,Clk,uPC); 
         --Branching: Branch PORT MAP(IR,flag,R7,R7);
         MappingALU: MapALU PORT MAP(control_word(12 downto 8),Cin,CMP,S(3 downto 0)); 
         CarryInput<=flag(0); 
         ALU_comp: finalmux PORT MAP(Cin,CMP,Y,outbus,S(3 downto 0),ALUOut,flag,CarryOut,CarryInput);  

         --Y<= "000000"&IR(9 DOWNTO 0) when uPC ="000100000";
         Rsrc <= IR(8 DownTo 6);
         Rdst <= IR(2 DownTo 0);


	 --tri_IR: tri_state_buffer port map(fsource(3),r33,temp);
	  
	
END Architecture;