--and datapath_tb.vhd file: <This is the filename>
LIBRARY ieee;
USE ieee.std_logic_1164.all;


--entity declaration only; no definition here
ENTITY phase2_tb IS
END ENTITY phase2_tb;


--Architecture of the testbench with the signal names 
ARCHITECTURE phase2_tb_arch OF phase2_tb IS
--Add any other signalsto see in your simulation
	SIGNAL PCout_tb : std_logic := '0';
	signal LOout_tb, HIout_tb, INPORTout_tb, MDRout_tb, Cout_tb: std_logic;
	SIGNAL HIin_tb, LOin_tb, ZLOout_tb, ZHIout_tb, Coutin_tb, INPORTin_tb, OUTPORTin_tb, MARin_tb, Zin_tb, PCin_tb, MDRin_tb, IRin_tb, Yin_tb : std_logic;
	
	SIGNAL IncPC_tb, readS_tb, writeS_tb, andS_tb, orS_tb, addS_tb, subS_tb, mulS_tb, divS_tb, shrS_tb, shlS_tb, rorS_tb, rolS_tb, negS_tb, notS_tb: std_logic;
	
	--signal R0in_tb, R1in_tb, R2in_tb, R3in_tb, R4in_tb, R5in_tb, R6in_tb, R7in_tb, R8in_tb, R9in_tb, R10in_tb, R11in_tb, R12in_tb, R13in_tb, R14in_tb, R15in_tb : std_logic;
	--signal R0out_tb, R1out_tb, R2out_tb, R3out_tb, R4out_tb, R5out_tb, R6out_tb, R7out_tb, R8out_tb, R9out_tb, R10out_tb, R11out_tb, R12out_tb, R13out_tb, R14out_tb, R15out_tb : std_logic; 
	
	signal Gra_tb, Grb_tb, Grc_tb, BAout_tb, Rin_tb, Rout_tb : std_logic;
	signal CONin_tb, con_tb : std_logic;
	SIGNAL Clock_tb, reset_tb : std_logic;
	SIGNAL Mdatain_tb, INPORTval_tb, OUTPORTval_tb : std_logic_vector (31 downto 0);
--	TYPE State IS (default, Reg_load1a, Reg_load1b, Reg_load2a, Reg_load2b, Reg_load3a, Reg_load3b, T0, T1, T2, T3, T4, T5, T6, T7);
	TYPE State IS (default, PC_load1a, PC_load1b, T0, T1, T2, T2b, T3, T4, T5, T6, T6b, T7, Tresult);
	SIGNAL Present_state: State:= default;
	
	type instrucState is (ld1, ld2, ldi1, ldi2, st1, st1_check, st2, st2_check, addi, andi, ori, preloadR1, preloadR2, preloadR3, brzr_no, brzr_yes,
	brnz_no, brnz_yes, brpl_no, brpl_yes, brmi_no, brmi_yes, preloadR1a, jr, preloadR1b, jal, mfhi, mflo, IOin, IOout);
	signal present_instruc: instrucState := ld1;
--component instantiation of the datapath

COMPONENT datapath
PORT (

	--R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in : in std_logic;
	--R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out : in std_logic;
	InPortData, OUTPORTdata : in std_logic_vector(31 downto 0);
	Zin, HIin, LOin, PCin, Coutin, INPORTin, OUTPORTin, IRin, MDRin, MARin, Yin : in std_logic;
	PCout, ZLOout, ZHIout, LOout, HIout, INPORTout, MDRout, Cout : in std_logic;
	con : out std_logic;
	conIN : in std_logic;
	readS, writeS, andS, orS, addS, subS, mulS, divS, shrS, shlS, rorS, rolS, negS, notS : in std_logic;
	
	busGra, busGrb, busGrc, busRin, busRout, busBAout : in std_logic;
	IncPC : in std_logic;
	Clock, reset : in std_logic
	--Mdatain : in std_logic_vector (31 downto 0)
	
--	PCout, ZLOout, MDRout, R2out, R4out : in std_logic;
--	MARin, Zin, PCin, MDRin, IRin, Yin: in std_logic;
--	IncPC, ReadS, ANDS, R5in, R2in, R4in: in std_logic;
--	Clock : in std_logic;
--	Mdatain : in std_logic_vector (31 downto 0)
	);
END COMPONENT datapath;


BEGIN
DUT  : datapath
--port mapping: between the dut and the testbench signals
PORT MAP (
	INPORTdata => INPORTval_tb,
	OUTPORTdata => OUTPORTval_tb,
	
	PCout => PCout_tb,
	ZHIout => ZHIout_tb,
	ZLOout => ZLOout_tb,
	MDRout => MDRout_tb,
	LOout => LOout_tb, 
	HIout => HIout_tb, 
	INPORTout => INPORTout_tb,  
	Cout => Cout_tb,
	
	busGra => Gra_tb,
	busGrb => Grb_tb, 
	busGrc => Grc_tb, 
	busRin => Rin_tb, 
	busRout => Rout_tb, 
	busBAout => BAout_tb,
	
	
	LOin => LOin_tb,
	HIin => HIin_tb,
	Coutin => Coutin_tb,
	INPORTin => INPORTin_tb, 
	OUTPORTin => OUTPORTin_tb,
	MARin=>MARin_tb,
	Zin=>Zin_tb,
	PCin=>PCin_tb,
	MDRin=>MDRin_tb,
	IRin=>IRin_tb,
	Yin=>Yin_tb,
	IncPC =>IncPC_tb,
	
	con => con_tb,
	conIN => conIN_tb,
	
	writeS => writeS_tb,
	readS=>readS_tb,
	andS=>andS_tb,
	orS => orS_tb, 
	addS => addS_tb, 
	subS => subS_tb,  
	mulS => mulS_tb, 
	divS => divS_tb, 
	shrS => shrS_tb, 
	shlS => shlS_tb, 
	rorS => rorS_tb, 
	rolS => rolS_tb,  
	negS => negS_tb, 
	notS => notS_tb,
	
	Clock=>Clock_tb,
	reset => reset_tb
	);
	--add test logic here
	Clock_process: PROCESS IS 
	BEGIN
		Clock_tb <= '1', '0' after 10 ns;
		Wait for 20 ns;
	END PROCESS Clock_process;
	
	
	
	PROCESS (Clock_tb)  IS--finite state machine
	BEGIN
	IF (rising_edge (Clock_tb)) THEN   --if clock rising-edge
	CASE Present_state IS 
		WHEN Default=>	Present_state <= PC_load1a;
		WHEN PC_load1a=> Present_state <= PC_load1b;
		WHEN PC_load1b=>Present_state <= T0;
--		WHEN Reg_load2a=>Present_state <= Reg_load2b;
--		WHEN Reg_load2b=>Present_state <= Reg_load3a;
--		WHEN Reg_load3a=>Present_state <= Reg_load3b;
--		WHEN Reg_load3b=>Present_state <= T0;
		--WHEN Default => Present_state <=T0;
		WHEN T0 =>Present_state <= T1;
		WHEN T1 =>Present_state <= T2;
		WHEN T2=>Present_state <= T2b;
		WHEN T2b=>Present_state <= T3;
		WHEN T3=>Present_state <= T4;
		WHEN T4 =>Present_state <= T5;
		WHEN T5 =>Present_state <= T6;
		WHEN T6 =>Present_state <= T6b;
		WHEN T6b =>Present_state <= T7;
		
		WHEN T7 => Present_state <= Tresult;
		WHEN Tresult => 
			case present_instruc is
				when ld1 => present_instruc <= ld2;
				when ld2 => present_instruc <= ldi1;
				when ldi1 => present_instruc <= ldi2;
				when ldi2 => present_instruc <= st1;
				when st1 => present_instruc <= st1_check;
				when st1_check => present_instruc <= st2;
				when st2 => present_instruc <= st2_check;
				when st2_check => present_instruc <= addi;
				when addi => present_instruc <= andi;
				when andi => present_instruc <= ori;
				when ori => present_instruc <= preloadR1;
				
				when preloadR1 => present_instruc <= preloadR2;
				when preloadR2 => present_instruc <= preloadR3;
				when preloadR3 => present_instruc <= brzr_no;
				when brzr_no => present_instruc <= brzr_yes;
				when brzr_yes => present_instruc <= brnz_no;
				when brnz_no => present_instruc <= brnz_yes;
				when brnz_yes => present_instruc <= brpl_no;
				when brpl_no => present_instruc <= brpl_yes;
				when brpl_yes => present_instruc <= brmi_no;
				when brmi_no => present_instruc <= brmi_yes;
				when brmi_yes => present_instruc <= preloadR1a; 
				
				when preloadR1a => present_instruc <= jr;
				when jr => present_instruc <= preloadR1b;
				when preloadR1b => present_instruc <= jal;
				when jal => present_instruc <= mfhi;				
				when mfhi => present_instruc <= mflo;
				when mflo => present_instruc <= IOin;
				when IOin => present_instruc <= IOout;
				when others =>
			end case;
			Present_state <= Default;
		WHEN OTHERS =>
		END CASE;
		END IF;
		END PROCESS;

PROCESS (Present_state, present_instruc) IS--do the required job ineach state
BEGIN 
case present_instruc is 
	when ld1 =>  -- address 0
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
				
			WHEN PC_load1a=>
				INPORTval_tb <= x"00000000";
				readS_tb <= '0', '1' after 10 ns, '0' after 25 ns; --the first zero is there for completeness
				INPORTin_tb <= '0', '1' after 10 ns, '0' after 25 ns;
			WHEN PC_load1b=> 
				PCin_tb <= '1', '0' after 25 ns;
				INPORTout_tb <= '1', '0' after 25 ns;
				
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 20 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when ld2 => -- address 1
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				readS_tb <= '1', '0' after 25 ns;
			WHEN PC_load1b=> 
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1' after 2 ns, '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when ldi1 => -- address 2
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				readS_tb <= '1', '0' after 25 ns;
			WHEN PC_load1b=> 
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1' after 2 ns, '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 25 ns;   
				Gra_tb <= '1', '0' after 25 ns;   
				Rin_tb <= '1', '0' after 25 ns;   
	
			WHEN OTHERS =>
			END CASE;
			
	when ldi2 => -- address 3
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				readS_tb <= '1', '0' after 25 ns;
			WHEN PC_load1b=> 
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1' after 2 ns, '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 25 ns;   
				Gra_tb <= '1', '0' after 25 ns;   
				Rin_tb <= '1', '0' after 25 ns;   
			
			WHEN OTHERS =>
			END CASE;
	when st1 => -- address 4
		CASE Present_state IS   --assert the required signalsin each clock cycle
			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
	
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;

				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
				Rout_tb <= '1', '0' after 45 ns;
				
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
				
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 25 ns;
				writeS_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when st1_check => -- address 5
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';

			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;

				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 45 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when st2 => -- address 6
		CASE Present_state IS   --assert the required signalsin each clock cycle
			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;

				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
				Rout_tb <= '1', '0' after 45 ns;
				
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
				
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 25 ns;
				writeS_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when st2_check => -- address 7
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
			WHEN PC_load1b=> 
				
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;

				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 45 ns;
			
			WHEN OTHERS =>
			END CASE;		
			
	when addi =>  -- address 8
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				readS_tb <= '1', '0' after 25 ns;
			WHEN PC_load1b=> 
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1' after 2 ns, '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				Rin_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;
			
	when andi => -- address 9
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				readS_tb <= '1', '0' after 25 ns;
			WHEN PC_load1b=> 
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1' after 2 ns, '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				andS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				Rin_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when ori =>  -- address 10
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				readS_tb <= '1', '0' after 25 ns;
			WHEN PC_load1b=> 
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1' after 2 ns, '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				orS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				Rin_tb <= '1', '0' after 25 ns;
				Gra_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
			
				
			WHEN T7 =>
			
			WHEN OTHERS =>
			END CASE;
			
	when preloadR1 => -- address 11 read from address 256, has value 9
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 20 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when preloadR2 => -- address 12 read from address 257, has zero value
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 20 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when preloadR3 => -- address 13 read from address 258, has value -60
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 20 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when brzr_no => -- address 14
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
				
				
			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1' after 2 ns, '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;
			
			
	when brzr_yes => -- address 15
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
			
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1' after 2 ns, '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;
			
	when brnz_no => -- address 52
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
			
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1', '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;				
			
	when brnz_yes => -- address 53 increments PC by 36, RAM address 90 was not working, Whitehall said to avoid it
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
			
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1', '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;	
			
	when brpl_no => -- address 91
			CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
			
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1', '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;	
	
	when brpl_yes => -- address 92
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
			
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1', '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;
			
	when brmi_no => -- address 129
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
				
			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1', '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;
			
	when brmi_yes => -- address 130
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
				
			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1', '0' after 25 ns;
				CONin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				PCout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				Cout_tb <= '1', '0' after 25 ns;   
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN T6 =>
			WHEN T6b =>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN T7 =>
				PCout_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
			WHEN Tresult => 
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= con_tb, '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;
			
	when preloadR1a => -- address 167 read from address 19
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0'; conIN_tb <= '0';
				
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 20 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when jr => -- address 168
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0';
				
			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1' after 2 ns, '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when preloadR1b => -- address 69 read from address 20
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Grb_tb <= '1', '0' after 25 ns;
				BAout_tb <= '1', '0' after 25 ns;
				Yin_tb <= '1', '0' after 25 ns;
			WHEN T4=>
				Cout_tb <= '1', '0' after 25 ns;
				addS_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T5 =>		
				ZLOout_tb <= '1', '0' after 20 ns;   
				MARin_tb <= '1', '0' after 25 ns;
				
			WHEN T6 =>
			WHEN T6b =>
				MDRin_tb <= '1', '0' after 25 ns;
				readS_tb <= '1', '0' after 25 ns;
				
			WHEN T7 =>
				MDRout_tb <= '1', '0' after 20 ns;
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
			
	when jal => -- address 70
		CASE Present_state IS   --assert the required signals in each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0';  Rout_tb <= '0'; writeS_tb <= '0';
				
			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;  
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns; 
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1' after 2 ns, '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;
			
			WHEN OTHERS =>
			END CASE;
	
	when mfhi => --address 421
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				INPORTval_tb <= x"00ABCABC";
				readS_tb <= '0', '1' after 10 ns, '0' after 25 ns; --the first zero is there for completeness
				INPORTin_tb <= '0', '1' after 10 ns, '0' after 25 ns;
			WHEN PC_load1b=> 
				HIin_tb <= '1', '0' after 25 ns;
				INPORTout_tb <= '1', '0' after 25 ns;
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				HIout_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
		
				
			WHEN OTHERS =>
			END CASE;
			
	when mflo => --address 421
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				INPORTval_tb <= x"00DEFDEF";
				readS_tb <= '0', '1' after 10 ns, '0' after 25 ns; --the first zero is there for completeness
				INPORTin_tb <= '0', '1' after 10 ns, '0' after 25 ns;
			WHEN PC_load1b=> 
				LOin_tb <= '1', '0' after 25 ns;
				INPORTout_tb <= '1', '0' after 25 ns;
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				LOout_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
			WHEN OTHERS =>
			END CASE;
			
	when IOin => --address 422
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
				
			WHEN PC_load1a=>
				INPORTval_tb <= x"88888888";
				readS_tb <= '0', '1' after 10 ns, '0' after 25 ns; --the first zero is there for completeness
				INPORTin_tb <= '0', '1' after 10 ns, '0' after 25 ns;
			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rin_tb <= '1', '0' after 25 ns;
				INPORTout_tb <= '1', '0' after 25 ns;
			
				
			WHEN OTHERS =>
			END CASE;
			
	when IOout => --address 423
		CASE Present_state IS   --assert the required signalsin each clock cycle

			WHEN Default=>	
				PCout_tb <= '0'; LOout_tb <= '0'; HIout_tb <= '0'; INPORTout_tb <= '0'; MDRout_tb <= '0'; Cout_tb <= '0'; HIin_tb <= '0'; LOin_tb <= '0'; 
				ZLOout_tb <= '0';ZHIout_tb <= '0'; Coutin_tb <= '0'; INPORTin_tb  <= '0'; OUTPORTin_tb <= '0'; MARin_tb  <= '0'; Zin_tb  <= '0'; 
				PCin_tb  <= '0'; MDRin_tb  <= '0'; IRin_tb  <= '0'; Yin_tb  <= '0'; 
				IncPC_tb <= '0'; readS_tb  <= '0'; andS_tb  <= '0'; orS_tb  <= '0'; addS_tb  <= '0'; subS_tb  <= '0'; mulS_tb  <= '0'; divS_tb  <= '0'; 
				shrS_tb  <= '0'; shlS_tb  <= '0'; rorS_tb  <= '0'; rolS_tb  <= '0'; negS_tb  <= '0'; notS_tb  <= '0';	reset_tb <= '0';
				Gra_tb <= '0'; Grb_tb <= '0'; Grc_tb <= '0'; BAout_tb <= '0'; Rin_tb <= '0'; Rout_tb <= '0'; writeS_tb <= '0';
			
				
			WHEN T0 => --see if you need to de-assert these signals
				PCout_tb <= '1', '0' after 25 ns;
				MARin_tb <= '1', '0' after 25 ns;
				IncPC_tb <= '1', '0' after 25 ns;
				Zin_tb <= '1', '0' after 25 ns;
				
			WHEN T1=>
				ZLOout_tb <= '1', '0' after 25 ns;
				PCin_tb <= '1', '0' after 25 ns;   
				readS_tb <= '1', '0' after 25 ns;    
				
			WHEN T2 =>
				readS_tb <= '1', '0' after 25 ns;  
				MDRin_tb <= '1', '0' after 25 ns;
			WHEN T2b=>
				MDRout_tb <= '1', '0' after 25 ns;   
				IRin_tb <= '1', '0' after 25 ns;
				
			WHEN T3=>
				Gra_tb <= '1', '0' after 25 ns;
				Rout_tb <= '1', '0' after 25 ns;
				OUTPORTin_tb <= '1', '0' after 25 ns;
			
				
			WHEN OTHERS =>
			END CASE;
	when others =>
	end case;
END PROCESS;
END ARCHITECTURE phase2_tb_arch;