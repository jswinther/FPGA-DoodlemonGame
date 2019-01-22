library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Nunchuck_v1_0_S00_AXI is
	generic (
		-- Users to add parameters here
CLK_DIV : integer := 500;
		NUNCHUCK_INIT_ADR : std_logic_vector (7 downto 0) := x"A4";
		NUNCHUCK_INIT_REG : std_logic_vector (7 downto 0) := "01000000";
		NUNCHUCK_INIT_REG2 : std_logic_vector (7 downto 0) := "00000000";
		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
		
			 I2C_SDA : inout std_logic;
             I2C_SCL : inout std_logic;
             Res : in std_logic;

		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Write channel Protection type. This signal indicates the
    		-- privilege and security level of the transaction, and whether
    		-- the transaction is a data access or an instruction access.
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		-- Write address valid. This signal indicates that the master signaling
    		-- valid write address and control information.
		S_AXI_AWVALID	: in std_logic;
		-- Write address ready. This signal indicates that the slave is ready
    		-- to accept an address and associated control signals.
		S_AXI_AWREADY	: out std_logic;
		-- Write data (issued by master, acceped by Slave) 
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
    		-- valid data. There is one write strobe bit for each eight
    		-- bits of the write data bus.    
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		-- Write valid. This signal indicates that valid write
    		-- data and strobes are available.
		S_AXI_WVALID	: in std_logic;
		-- Write ready. This signal indicates that the slave
    		-- can accept the write data.
		S_AXI_WREADY	: out std_logic;
		-- Write response. This signal indicates the status
    		-- of the write transaction.
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
    		-- is signaling a valid write response.
		S_AXI_BVALID	: out std_logic;
		-- Response ready. This signal indicates that the master
    		-- can accept a write response.
		S_AXI_BREADY	: in std_logic;
		-- Read address (issued by master, acceped by Slave)
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Protection type. This signal indicates the privilege
    		-- and security level of the transaction, and whether the
    		-- transaction is a data access or an instruction access.
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		-- Read address valid. This signal indicates that the channel
    		-- is signaling valid read address and control information.
		S_AXI_ARVALID	: in std_logic;
		-- Read address ready. This signal indicates that the slave is
    		-- ready to accept an address and associated control signals.
		S_AXI_ARREADY	: out std_logic;
		-- Read data (issued by slave)
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of the
    		-- read transfer.
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
    		-- signaling the required read data.
		S_AXI_RVALID	: out std_logic;
		-- Read ready. This signal indicates that the master can
    		-- accept the read data and response information.
		S_AXI_RREADY	: in std_logic
	);
end Nunchuck_v1_0_S00_AXI;

architecture arch_imp of Nunchuck_v1_0_S00_AXI is

	
        -- SCL related
        signal clk_counter : unsigned(8 downto 0) := "000000000";
        signal clk_counter_next : unsigned(8 downto 0) := "000000000";
        signal clk_counter_res : unsigned(8 downto 0) := "000000000";
        signal clk_response : std_logic := '1';
        signal clk_w : std_logic := '1';
        signal clk_stretch : std_logic := '0';
    
        -- SDA related
        signal w : std_logic := '1';
        signal SDA_out : std_logic := '1';
        signal run_I2C : std_logic := '1';
        signal expired : std_logic := '0';
        
        -- State
        signal init_state : unsigned(6 downto 0) := "1111111";
        signal to_adr : std_logic := '0';
        signal to_reg2 : std_logic := '0';
        signal redirect : std_logic_vector(2 downto 0) := "000"; 
        signal to_redirect : std_logic := '0';
        
        -- Data
        signal data_1 : std_logic_vector(7 downto 0);
        signal data_2 : std_logic_vector(7 downto 0);
        signal data_3 : std_logic_vector(7 downto 0);
        signal data_4 : std_logic_vector(7 downto 0);
        signal data_5 : std_logic_vector(7 downto 0);
        signal data_6 : std_logic_vector(7 downto 0);
        
        signal data_1_conv : std_logic_vector(7 downto 0);
        signal data_2_conv : std_logic_vector(7 downto 0);
        signal data_6_conv : std_logic_vector(7 downto 0);
        
        signal send_data_1 :std_logic;
        signal send_data_2 :std_logic;
        signal send_data_6 :std_logic;
        
        signal adr_data_1 : std_logic_vector(3 downto 0) := "0000";
        signal adr_data_2 : std_logic_vector(3 downto 0) := "0100";
        signal adr_data_6 : std_logic_vector(3 downto 0) := "1000";
        signal adr_vector : std_logic_vector(2 downto 0);
        
        
        -- clkdiv
        
        signal clk_divider : unsigned(1 downto 0) := "10";
        
        -- allow to run
        signal allow : std_logic;
       signal run : std_logic;
       -- buffers
       signal data_in_buffer : std_logic;
       signal clk_in : std_logic;
       
       -- triggers
       
      signal ack_trigger : std_logic := '0';
      signal prestretch_trigger : std_logic := '0';
      signal stretch_trigger :std_logic := '0';
      signal restart_i2c : std_logic := '0';
      signal data_buffer: std_logic := '0';
      signal inverted : std_logic := '0';



	-- AXI4LITE signals
	signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	: std_logic;
	signal axi_wready	: std_logic;
	signal axi_bresp	: std_logic_vector(1 downto 0);
	signal axi_bvalid	: std_logic;
	signal axi_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_arready	: std_logic;
	signal axi_rdata	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_rresp	: std_logic_vector(1 downto 0);
	signal axi_rvalid	: std_logic;
	signal bitmask : std_logic_vector(23 downto 0) := "000000000000000000000000";
	signal s00_axi_aclk : std_logic;

	-- Example-specific design signals
	-- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	-- ADDR_LSB is used for addressing 32/64 bit registers/memories
	-- ADDR_LSB = 2 for 32 bits (n downto 2)
	-- ADDR_LSB = 3 for 64 bits (n downto 3)
	constant ADDR_LSB  : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := 1;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 4
	signal slv_reg0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg1	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg3	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg_rden	: std_logic;
	signal slv_reg_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;
	signal aw_en	: std_logic;

begin
	-- I/O Connections assignments

	S_AXI_AWREADY	<= axi_awready;
	S_AXI_WREADY	<= axi_wready;
	S_AXI_BRESP	<= axi_bresp;
	S_AXI_BVALID	<= axi_bvalid;
	S_AXI_ARREADY	<= axi_arready;
	S_AXI_RDATA	<= axi_rdata;
	S_AXI_RRESP	<= axi_rresp;
	S_AXI_RVALID	<= axi_rvalid;
	-- Implement axi_awready generation
	-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	-- de-asserted when reset is low.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	      aw_en <= '1';
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- slave is ready to accept write address when
	        -- there is a valid write address and write data
	        -- on the write address and data bus. This design 
	        -- expects no outstanding transactions. 
	        axi_awready <= '1';
	        elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then
	            aw_en <= '1';
	        	axi_awready <= '0';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;
	end process;

	-- Implement axi_awaddr latching
	-- This process is used to latch the address when both 
	-- S_AXI_AWVALID and S_AXI_WVALID are valid. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awaddr <= (others => '0');
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- Write Address latching
	        axi_awaddr <= S_AXI_AWADDR;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_wready generation
	-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	-- de-asserted when reset is low. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1' and aw_en = '1') then
	          -- slave is ready to accept write data when 
	          -- there is a valid write address and write data
	          -- on the write address and data bus. This design 
	          -- expects no outstanding transactions.           
	          axi_wready <= '1';
	      else
	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;
	end process; 

	-- Implement memory mapped register select and write logic generation
	-- The write data is accepted and written to memory mapped registers when
	-- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	-- select byte enables of slave registers while writing.
	-- These registers are cleared when reset (active low) is applied.
	-- Slave register write enable is asserted when valid address and data are available
	-- and the slave is ready to accept the write address and write data.
	slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID ;

	process (S_AXI_ACLK)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      slv_reg0 <= (others => '0');
	      slv_reg1 <= (others => '0');
	      slv_reg2 <= (others => '0');
	      slv_reg3 <= (others => '0');
	    else
	       case adr_vector is
	       when "100" =>
	       slv_reg0 <= bitmask & data_1_conv;
	       when "010" =>
	       slv_reg1 <= bitmask & data_2_conv;
	       when "001" =>
	       slv_reg2 <= bitmask & data_6_conv;
	       when others =>
	       slv_reg0 <= slv_reg0;
	       slv_reg1 <= slv_reg1;
	       slv_reg2 <= slv_reg2;
	       slv_reg3 <= slv_reg3;
	       end case;
	        
--	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
--	      if (slv_reg_wren = '1') then
--	        case loc_addr is
--	          when b"00" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 0
--	                slv_reg0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
--	          when b"01" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 1
--	                slv_reg1(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
--	          when b"10" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 2
--	                slv_reg2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
--	          when b"11" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 3
--	                slv_reg3(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
--	          when others =>
--	            slv_reg0 <= slv_reg0;
--	            slv_reg1 <= slv_reg1;
--	            slv_reg2 <= slv_reg2;
--	            slv_reg3 <= slv_reg3;
--	        end case;
--	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement write response logic generation
	-- The write response and response valid signals are asserted by the slave 
	-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	-- This marks the acceptance of address and indicates the status of 
	-- write transaction.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	      axi_bresp   <= "00"; --need to work more on the responses
	    else
	      if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0'  ) then
	        axi_bvalid <= '1';
	        axi_bresp  <= "00"; 
	      elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
	        axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arready generation
	-- axi_arready is asserted for one S_AXI_ACLK clock cycle when
	-- S_AXI_ARVALID is asserted. axi_awready is 
	-- de-asserted when reset (active low) is asserted. 
	-- The read address is also latched when S_AXI_ARVALID is 
	-- asserted. axi_araddr is reset to zero on reset assertion.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	      axi_araddr  <= (others => '1');
	    else
	      if (axi_arready = '0' and S_AXI_ARVALID = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_arready <= '1';
	        -- Read Address latching 
	        axi_araddr  <= S_AXI_ARADDR;           
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arvalid generation
	-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	-- S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	-- data are available on the axi_rdata bus at this instance. The 
	-- assertion of axi_rvalid marks the validity of read data on the 
	-- bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	-- is deasserted on reset (active low). axi_rresp and axi_rdata are 
	-- cleared to zero on reset (active low).  
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then
	    if S_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	      axi_rresp  <= "00";
	    else
	      if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
	        -- Valid read data is available at the read data bus
	        axi_rvalid <= '1';
	        axi_rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
	        -- Read data is accepted by the master
	        axi_rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process;

	-- Implement memory mapped register select and read logic generation
	-- Slave register read enable is asserted when valid address is available
	-- and the slave is ready to accept the read address.
	slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid) ;

	process (slv_reg0, slv_reg1, slv_reg2, slv_reg3, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
	begin
	    -- Address decoding for reading registers
	    loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	    case loc_addr is
	      when b"00" =>
	        reg_data_out <= slv_reg0;
	      when b"01" =>
	        reg_data_out <= slv_reg1;
	      when b"10" =>
	        reg_data_out <= slv_reg2;
	      when b"11" =>
	        reg_data_out <= slv_reg3;
	      when others =>
	        reg_data_out  <= (others => '0');
	    end case;
	end process; 

	-- Output register or memory read data
	process( S_AXI_ACLK ) is
	begin
	  if (rising_edge (S_AXI_ACLK)) then
	    if ( S_AXI_ARESETN = '0' ) then
	      axi_rdata  <= (others => '0');
	    else
	      if (slv_reg_rden = '1') then
	        -- When there is a valid read address (S_AXI_ARVALID) with 
	        -- acceptance of read address by the slave (axi_arready), 
	        -- output the read dada 
	        -- Read address mux
	          axi_rdata <= reg_data_out;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;


	-- Add user logic here

-- Instantiation of Axi Bus Interface S00_AXI

-- Add user logic here
        s00_axi_aclk <= clk_divider(1);
        I2C_SCL <= clk_response when (clk_w = '1') else ('Z');
        I2C_SDA <= data_buffer when (w = '1') else ('Z');
        data_in_buffer <= I2C_SDA;
        data_buffer <= SDA_out;
        clk_in <= I2C_SCL;
        expired <= '1' when (clk_counter = (CLK_DIV-1)) else ('0');
        allow <= run_I2C and not(Res) and clk_w;
        run <= run_I2C and not(Res);
        inverted <= '1' when (redirect = "100") else ('0');
        adr_vector <= send_data_1 & send_data_2 & send_data_6;
        
        -- Decoder
        
data_1_conv <= (data_1 xor x"17");
data_2_conv <= (data_2 xor x"17");
data_6_conv <= (data_6 xor x"17");
 

   --------------- triggers     
        process (clk_counter,clk_response,clk_in)
        begin
        if (clk_counter < x"0EB") and (clk_response = '0') and (clk_counter > x"040") then
        ack_trigger <= '1';
        else
        ack_trigger <= '0';
       end if;
      
       -- PRESTRETCH_TRIGGER
       if (clk_counter < x"0EB") and (clk_response = '0')and (clk_counter > x"040") then
       
       prestretch_trigger <= '1';
       else
       prestretch_trigger <= '0';
       end if;
       
       
       if (clk_counter > x"17A") and (clk_in = '0') and (clk_counter < x"1F0") then
       stretch_trigger <= '1';
       else
       stretch_trigger <= '0';
       end if;
       
       
       
       end process;
  ------------------------
       
       
       
     process(S_AXI_ACLK)
    begin
    if rising_edge(S_AXI_ACLK) then
      clk_divider <= clk_divider + 1;
        end if;
      end process;
        
        
        -- 100kHz clock (SCL) for I2C  ( starts when start = 1 )
        -- initial = 1
        
        
  --     clk_counter <= clk_counter_next when ((allow = '1')  and (expired = '0')) else (clk_counter_res);
        
        process(s00_axi_aclk)



        
        begin
        
        if rising_edge(s00_axi_aclk) then
         case allow  and not(expired) and not(inverted)  is
               when '1' =>
            --   if ( clk_w = '1') then
           
           --    clk_counter_next <= clk_counter + 1;
           --    clk_counter <= clk_counter_next;
           
           clk_counter <= clk_counter + 1;
           
          --     end if;
               when others =>
             
               clk_counter <= clk_counter_res;
            
               end case;
     

               
               case allow is
              when '1' => 
             
              if (clk_counter = (CLK_DIV-1) 
              -- CLOCK INVERTER
               and not(init_state ="0001010")
               and not(init_state ="0010100") 
          --    and not(init_state ="0011110")  --- after stop, stay high  
               and not(init_state ="0101001")
               and not(init_state ="0110011")
               and not(init_state ="0111101")
               and not(init_state = "1010001")
               and not(init_state="1000111")
               and not(init_state="1011011")
               and not(init_state="1100101")
          
               )  then
           
              clk_response <= not(clk_response);
              end if;
           
                            
              when others =>
             
               clk_response <= '1';
              
              end case;
                 
 
        end if;

        end process;
        
        
   -- FSM
   process(s00_axi_aclk)
   begin
   if rising_edge(s00_axi_aclk) then
   
  
   case(run) is
   
   when '1' => 
   if (((((clk_counter = x"0EA") and (clk_in = '0')) 
   or ((init_state = "1111111") and (clk_counter = x"0EA") and (clk_in = '1'))) and clk_w = '1') 
   or to_redirect = '1') then
   
   case (redirect) is
   
   -- STANDARD FLOW ( to_redirect must be 0 )
   
   when "000" => 
   init_state <= init_state + 1;
     
   --  REDIRECTOR TABLE ( to_redirect must be 1 )
   when "001" =>
   init_state <= "0000001";
   
   when "010" =>
   init_state <= "0010100";
   
   when "111" => 
   init_state <= "1111110";
   
   when "100" =>
   init_state <= "0011111";
   
   when "110" =>
   init_state <= "0011111";
   
   
  
  
   -- SINK OTHERS
   when others =>
   init_state <= init_state;
   end case;
   
   end if;
   
   
   when others => init_state <= (others => '1');
   end case;
   
     
   end if;
   end process;

    -- SDA input/output controller
    
    process(s00_axi_aclk,clk_counter,init_state,clk_in,clk_response)
    begin
        if rising_edge(s00_axi_aclk) then
    
    if ( run = '1') then
    
    case (init_state) is
    
--------------------------------------------------RESTART        
    when "1111110" =>                                
                    to_redirect <= '0'; 
                    redirect <= "000";
                    w <= '1'; 
                    SDA_out <= '1';
                    clk_stretch <= '0';
                    to_adr <= to_adr;        
   
       
--------------------------------------------------PRESTART    
    when "1111111" =>
                    SDA_out <= '1';
                           
                    w <= '1';
                    clk_stretch <= '0';
                    redirect <= "000";
                    to_redirect <= '0';
                    to_adr <= to_adr;
                    
                    
--------------------------------------------------START
    when "0000000" =>
                    SDA_out <= '0';
                                       
                    w <= '1';
                    clk_stretch <= '0';
                    redirect <= "000";
                    to_redirect <= '0';
                    to_adr <= to_adr;
                   
--------------------------------------------------W ADR BIT 7                   
    when "0000001" =>
                    SDA_out <= NUNCHUCK_INIT_ADR(7);
                    
                    w <= '1';
                    clk_stretch <= '0';
                    to_adr <= to_adr;
                    redirect <= "000"; 
                    to_redirect <= '0';
                   
                   
--------------------------------------------------W ADR BIT 6      
    when "0000010" =>
                    SDA_out <= NUNCHUCK_INIT_ADR(6);
                           
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;
                   
   
--------------------------------------------------W ADR BIT 5                                
    when "0000011" =>
                    SDA_out <= NUNCHUCK_INIT_ADR(5);
                           
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;
                                 
 
--------------------------------------------------W ADR BIT 4                                  
    when "0000100" =>
                    SDA_out <= NUNCHUCK_INIT_ADR(4);
                           
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;
                                 
 
 --------------------------------------------------W ADR BIT 3                                
    when "0000101" =>                    
                    SDA_out <= NUNCHUCK_INIT_ADR(3);
                                                
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr; 


--------------------------------------------------W ADR BIT 2                                           
    when "0000110" =>                    
                    SDA_out <= NUNCHUCK_INIT_ADR(2);
                                                  
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;


--------------------------------------------------W ADR BIT 1                            
    when "0000111" =>                    
                   SDA_out <= NUNCHUCK_INIT_ADR(1);
                                          
                   w <= w;
                   clk_stretch <= clk_stretch;
                   redirect <= redirect;
                   to_redirect <= to_redirect;
                   to_adr <= to_adr;

                                 
--------------------------------------------------W ADR BIT 0 then READ ENABLE FOR ACK                                              
    when "0001000" =>                                     
                    if (ack_trigger = '1') then
                        SDA_out <= SDA_out;
                        w <= '0';
                    else
                        w <= '1';
                        SDA_out <= NUNCHUCK_INIT_ADR(0);
                    end if;
                   
                   clk_stretch <= '0';
                   redirect <= redirect;
                   to_redirect <= to_redirect;
                   to_adr <= to_adr;

                   
--------------------------------------------------ACK FOR W ADR                   
    when "0001001" =>        
                    if (clk_response = '1') and (data_in_buffer = '1')  then
                          redirect <= "111"; 
                          to_redirect <= '1';                                   
                    else   
                          redirect <= redirect;
                          to_redirect <= to_redirect;
                    end if;                                                                                            

                    SDA_out <= SDA_out;   

                    w <= '0';
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;

                   
--------------------------------------------------IF A=1 JUMP TO REG 2                                           
    when "0001010" =>                    
                    if (to_adr = '1') then
                         redirect <= "010";
                         to_redirect <= '1';
                    
                    else 
                         redirect <= redirect;
                         to_redirect <= to_redirect;
                    end if;
                    
                    w <= w;                    
                    clk_stretch <= '0'; 
                    to_adr <= to_adr;
                    SDA_out <= NUNCHUCK_INIT_REG(7);
                          
    
--------------------------------------------------CLOCK STRETCHING AND W REG BIT 7                   
     when "0001011" =>                                     
                     if (stretch_trigger = '1') then                  
                            clk_stretch <= '1';
                     elsif(clk_in = '1') then
                            clk_stretch <= '0';
                     end if;
                     
                    w <= '1';
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;
                                                                       
                    SDA_out <= NUNCHUCK_INIT_REG(7);

                    
--------------------------------------------------W REG BIT 6                   
    when "0001100" =>
                    SDA_out <= NUNCHUCK_INIT_REG(6);
                                                  
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;                       


--------------------------------------------------W REG BIT 5                   
    when "0001101" =>                 
                    SDA_out <= NUNCHUCK_INIT_REG(5);
                                                  
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;
                    
                    
--------------------------------------------------W REG BIT 4                    
    when "0001110" =>                 
                    SDA_out <= NUNCHUCK_INIT_REG(4);
                                                  
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;


--------------------------------------------------W REG BIT 3                    
    when "0001111" =>                 
                    SDA_out <= NUNCHUCK_INIT_REG(3);
                                                  
                    w <= w;
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;


--------------------------------------------------W REG BIT 2
    when "0010000" =>                 
                    SDA_out <= NUNCHUCK_INIT_REG(2);
                    
                    w <= w;                    
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;      
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;          
                                                                             
 
--------------------------------------------------W REG BIT 1                                                    
    when "0010001" =>                 
                    SDA_out <= NUNCHUCK_INIT_REG(1);
                   
                    clk_stretch <= clk_stretch;
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;
                    w <= w;
                               
                   
  --------------------------------------------------W REG BIT 0 then READ ENABLE FOR ACK                                              
    when "0010010" =>                                     
                    if (ack_trigger = '1') then
                        SDA_out <= SDA_out;
                        w <= '0';
                    else
                        w <= '1';
                        SDA_out <= NUNCHUCK_INIT_REG(0);
                    end if;
                   
                   clk_stretch <= '0';
                   redirect <= redirect;
                   to_redirect <= to_redirect;
                   to_adr <= to_adr;

                   
--------------------------------------------------ACK FOR W REG                   
    when "0010011" =>        
                    if (clk_response = '1') and (data_in_buffer = '1')  then
                          redirect <= "111"; 
                          to_redirect <= '1';                                   
                    else   
                          redirect <= redirect;
                          to_redirect <= to_redirect;
                    end if;                                                                                            

                    SDA_out <= SDA_out;   

                    w <= '0';
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;

                   
--------------------------------------------------IDLE                                          
    when "0010100" =>                    
                    redirect <= "000";
                    to_redirect <= '0';
                    
                    w <= w;                    
                    clk_stretch <= '0'; 
                    to_adr <= to_adr;
                    SDA_out <= NUNCHUCK_INIT_REG2(7);
                          
    
--------------------------------------------------CLOCK STRETCHING AND W REG BIT 7                   
     when "0010101" =>                                     
                     if (stretch_trigger = '1') then                  
                            clk_stretch <= '1';
                     elsif(clk_in = '1') then
                            clk_stretch <= '0';
                     end if;
                     
                    w <= '1';
                    redirect <= redirect;
                    to_redirect <= to_redirect;
                    to_adr <= to_adr;
                                                                       
                    SDA_out <= NUNCHUCK_INIT_REG2(7);                                                                                                       


--------------------------------------------------W REG2 BIT 6                                 
    when "0010110" =>                                                                                           
                    SDA_out <= NUNCHUCK_INIT_REG2(6);  
                    
                    w <= w;                 
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;                 
                    redirect <= redirect;      
                    to_redirect <= to_redirect;                                                                        
  

--------------------------------------------------W REG2 BIT 5                                  
    when "0010111" => 
                    SDA_out <= NUNCHUCK_INIT_REG2(5);
        
                    w <= w;                 
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;                  
                    redirect <= redirect;      
                    to_redirect <= to_redirect;
                                                                                                                                                                                                      

--------------------------------------------------W REG2 BIT 4                                  
    when "0011000" => 
                    SDA_out <= NUNCHUCK_INIT_REG2(4);
    
                    w <= w;                 
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;                 
                    redirect <= redirect;      
                    to_redirect <= to_redirect;                                                                                                                                                                    


--------------------------------------------------W REG2 BIT 3                                  
    when "0011001" =>    
                    SDA_out <= NUNCHUCK_INIT_REG2(3);  

                    w <= w;                 
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;                  
                    redirect <= redirect;      
                    to_redirect <= to_redirect;                                                                                                                                                                  


--------------------------------------------------W REG2 BIT 2                                  
    when "0011010" =>
                    SDA_out <= NUNCHUCK_INIT_REG2(2);
                    
                    w <= w;                 
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;                  
                    redirect <= redirect;      
                    to_redirect <= to_redirect;                                                                                           
                                                                         

--------------------------------------------------W REG2 BIT 1                                  
    when "0011011" =>
                    SDA_out <= NUNCHUCK_INIT_REG2(1);
     
                w <= w;                 
                clk_stretch <= clk_stretch;
                to_adr <= to_adr;                  
                redirect <= redirect;      
                to_redirect <= to_redirect;                                                                                          
                                                                          
                                  
                                  
                                       
--------------------------------------------------W REG2 BIT 0 then READ ENABLE FOR ACK                                              
    when "0011100" =>                                     
                    if (ack_trigger = '1') then
                        SDA_out <= SDA_out;
                        w <= '0';
                    else
                        w <= '1';
                        SDA_out <= NUNCHUCK_INIT_REG2(0);
                    end if;
                   
                   clk_stretch <= '0';
                   redirect <= redirect;
                   to_redirect <= to_redirect;
                   to_adr <= to_adr;
                   
                   
--------------------------------------------------ACK FOR W REG  then PULLDOWN SIGNAL                                                                                                                        
    when "0011101" =>                                                                                          
                    SDA_out <= '0';                                                                        
                    w <= '0';                                                                                            
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;                 
                  
                    if (clk_response = '1') and (data_in_buffer = '1')  then                                  
                        redirect <= "111"; 
                        to_redirect <= '1';                                                                        
                    end if;                        
                    
                                                                                                                  
--------------------------------------------------STOP then  jmp TO 0011111
    when "0011110" =>
    
                    if(clk_in = '1') and  (clk_counter > x"067") then
                        SDA_out <= '1';
                    else
                        SDA_out <= SDA_out;
                    end if;
      
                    if(clk_counter = x"1E6") and (I2C_SDA = '1') then
                        redirect <= "100";
                        to_redirect <= '1';
                    end if;
         
                    w <= '1';
                    clk_stretch <= clk_stretch;
                    to_adr <= to_adr;                                                                             
    
 
 
--------------------------------------------------START                                 

 when "0011111" =>
 
                 if(clk_in = '1') and  (clk_counter > x"193") then
                    SDA_out <= '0';
                 else
                    SDA_out <= SDA_out;
                 end if;
 
                    to_adr <= to_adr;                  
                    redirect <= "000";      
                    to_redirect <= '0';
                 
                  w <= '1';                                               
                               

--------------------------------------------------W ADR BIT 7
 when "0100000" =>
      
                  SDA_out <= NUNCHUCK_INIT_ADR(7);
                     
         
                 if(to_adr = '0') then
                    redirect <= "001";
                    to_adr <= '1';
                    to_redirect <= '1';
 
                 else              
                    to_adr <= to_adr;                  
                    redirect <= "000";      
                    to_redirect <= '0';
                 end if;
 


                   
                   when "0100001" =>
                  -- to_adr <= '0';
                   SDA_out <= NUNCHUCK_INIT_ADR(6);
                      w <= w;                 
                clk_stretch <= clk_stretch;
                to_adr <= to_adr;                  
                redirect <= redirect;      
                to_redirect <= to_redirect;
                                
                   when "0100010" =>
                   SDA_out <= NUNCHUCK_INIT_ADR(5);
                   clk_stretch <= clk_stretch;
                                   to_adr <= to_adr;                  
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                    w <= w;  
                   
                   when "0100011" =>
                   SDA_out <= NUNCHUCK_INIT_ADR(4);
                   clk_stretch <= clk_stretch;
                                   to_adr <= to_adr;                  
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                    w <= w;  
                   
                   when "0100100" =>                    
                   SDA_out <= NUNCHUCK_INIT_ADR(3);
                   clk_stretch <= clk_stretch;
                                   to_adr <= to_adr;                  
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                    w <= w;  
                                                   
                   when "0100101" =>                    
                   SDA_out <= NUNCHUCK_INIT_ADR(2);
                   clk_stretch <= clk_stretch;
                                   to_adr <= to_adr;                  
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                    w <= w;  
                                                   
                   when "0100110" =>                    
                   SDA_out <= NUNCHUCK_INIT_ADR(1);
                   clk_stretch <= clk_stretch;
                                   to_adr <= to_adr;                  
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                    w <= w;  
                     
                     when "0100111" => --------- ACK                                                                            
                                                     
                   if (ack_trigger = '1') then      
                   SDA_out <= 'Z';                                                                        
                   w <= '0';                                                                              
                   else                                                                                       
                   SDA_out <= '1';  -- read 
                   w <= '1';                                                       
                   end if;   
                   
             to_adr <= to_adr;                  
            redirect <= redirect;      
            to_redirect <= to_redirect;
             clk_stretch <= clk_stretch;
                                                                        
                                                                        
                   
                                                                                                    
                                                     
                   when "0101000" => -------------- INTERRUPT
                   
                                                                                                              
------------------------------------------------------------------------------------    
--ACKNOWLEDGING                                        
if (clk_response = '1') and (data_in_buffer = '1')  then                                  
redirect <= "110"; 
   to_adr <= '1';   
to_redirect <= '1'; 
else
redirect <= "000";
to_redirect <= '0';
   to_adr <= to_adr;                                                                           
end if;
           
  clk_stretch <= clk_stretch;                  
                                                                                 
------------------------------------------------------------------------------------                                                     
                                                     
                   if ((prestretch_trigger = '1')) then                                  
                   SDA_out <= '1';                                                                        
                   w <= '1';                                                                              
                   else                                                                                       
                   SDA_out <= 'Z';                                                                        
                   w <= '0';                                                                              
                   end if;         
                   
                   when "0101001" =>
                   
                   w <= '0';  
                        
                   clk_stretch <= clk_stretch; 
                                    
                    SDA_out <= SDA_out;        
                    redirect <= redirect;      
                    to_redirect <= to_redirect;
                     
                     
                   when "0101010" =>
                   
                                   ------------------------------------------------------------------
                                       -- CLK STRETCHING   
                      if (stretch_trigger = '1') then                  
                    clk_stretch <= '1';
                    elsif(clk_in = '1') then
                    clk_stretch <= '0';
                     end if;
                     to_adr <= to_adr;           
                 
                      w <= w;                    
                      SDA_out <= SDA_out;        
                      redirect <= redirect;      
                      to_redirect <= to_redirect;
            -----------------------------------------------------------------------------------
                   
                   if clk_response = '1' then                    
                   data_1(7) <= data_in_buffer;
                   end if;
                                   to_adr <= to_adr;                  
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                   w <= w;
                                   SDA_out <= SDA_out;
                   when "0101011" =>
                   if clk_response = '1' then                     
                   data_1(6) <= data_in_buffer;
                   end if;
                   
                   clk_stretch <= clk_stretch;
                                   to_adr <= to_adr;                  
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                   SDA_out <= SDA_out;
                                      w <= w;
                   
                   when "0101100" =>
                   if clk_response = '1' then      
                   data_1(5) <= data_in_buffer;
                   end if; 
                   to_adr <= to_adr;                  
                                                      redirect <= redirect;      
                                                      to_redirect <= to_redirect;
                                                      SDA_out <= SDA_out;
                                                         w <= w;  
                                                          clk_stretch <= clk_stretch;      
                   when "0101101" =>
                   if clk_response = '1' then               
                   data_1(4) <= data_in_buffer;
                   end if;
                   to_adr <= to_adr;                  
                                                      redirect <= redirect;      
                                                      to_redirect <= to_redirect;
                                                      SDA_out <= SDA_out;
                                                         w <= w; 
                                                          clk_stretch <= clk_stretch;
                   when "0101110" =>
                   if clk_response = '1' then       
                   data_1(3) <= data_in_buffer; 
                   end if;
                   to_adr <= to_adr;                  
                                                      redirect <= redirect;      
                                                      to_redirect <= to_redirect;
                                                      SDA_out <= SDA_out;
                                                         w <= w;
                                                          clk_stretch <= clk_stretch;
                   when "0101111" =>
                   if clk_response = '1' then       
                   data_1(2) <= data_in_buffer;
                   end if;
                   to_adr <= to_adr;                  
                                                      redirect <= redirect;      
                                                      to_redirect <= to_redirect;
                                                      SDA_out <= SDA_out; 
                                                         w <= w;
                                                          clk_stretch <= clk_stretch;
                   when "0110000" =>
                   if clk_response = '1' then       
                   data_1(1) <= data_in_buffer;
                   end if;
                   to_adr <= to_adr;                  
                                                      redirect <= redirect;      
                                                      to_redirect <= to_redirect;
                                                      SDA_out <= SDA_out; 
                                                         w <= w;
                                                          clk_stretch <= clk_stretch;
                   when "0110001" =>
                   if clk_response = '1' then       
                   data_1(0) <= data_in_buffer;
                   end if;
                   to_adr <= to_adr;                  
                                                      redirect <= redirect;      
                                                      to_redirect <= to_redirect;
                                                       clk_stretch <= clk_stretch;
                                                       SDA_out <= SDA_out; 
                                               w <= w;
                                                       
                                                      
                   SDA_out <= '0'; 
                      w <= w;       
                   
                   when "0110010" =>     -------- MASTER ACK
                   w <= '1';
                   to_adr <= to_adr;           
                   clk_stretch <= clk_stretch; 
                                   
                    SDA_out <= SDA_out;        
                    redirect <= redirect;      
                    to_redirect <= to_redirect;
                                                                            clk_stretch <= clk_stretch;
                   
                                     
                   when "0110011" =>
                   SDA_out <= '0';
                   to_adr <= to_adr;           
                   clk_stretch <= clk_stretch; 
                    w <= w;                    
                         
                    redirect <= redirect;      
                    to_redirect <= to_redirect; 
                      w <= w;
                                                                            clk_stretch <= clk_stretch;
                   
                   
                        
                                 when "0110100" =>
                                 
                                                 ------------------------------------------------------------------
                                                     -- CLK STRETCHING   
                                    if (stretch_trigger = '1') then                  
                                  clk_stretch <= '1';
                                  elsif(clk_in = '1') then
                                  clk_stretch <= '0';
                                   end if;
                          -----------------------------------------------------------------------------------
                                 
                                 w <= '0';
                                 if clk_response = '1' then                   
                                 data_2(7) <= data_in_buffer;
                                 end if;
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                    SDA_out <= SDA_out;
                                                 
                                                                                                                            clk_stretch <= clk_stretch;
                                                                    
                                 when "0110101" =>
                                 if clk_response = '1' then                     
                                 data_2(6) <= data_in_buffer;
                                 end if;
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                    SDA_out <= SDA_out;
                                                                      w <= w;
                                                                                                                            clk_stretch <= clk_stretch;
                                 when "0110110" =>
                                 if clk_response = '1' then      
                                 data_2(5) <= data_in_buffer;
                                 end if;
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                    SDA_out <= SDA_out;  
                                                                      w <= w;
                                                                                                                            clk_stretch <= clk_stretch;       
                                 when "0110111" =>
                                 if clk_response = '1' then               
                                 data_2(4) <= data_in_buffer; 
                                 end if;
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                    SDA_out <= SDA_out;
                                                                      w <= w;
                                                                                                                            clk_stretch <= clk_stretch;
                                 when "0111000" =>
                                 if clk_response = '1' then       
                                 data_2(3) <= data_in_buffer; 
                                 end if;
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                    SDA_out <= SDA_out;
                                                                      w <= w;
                                                                                                                            clk_stretch <= clk_stretch;
                                 when "0111001" =>
                                 if clk_response = '1' then       
                                 data_2(2) <= data_in_buffer; 
                                 end if;
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                    SDA_out <= SDA_out;
                                                                      w <= w;
                                                                                                                            clk_stretch <= clk_stretch;
                                 when "0111010" =>
                                 if clk_response = '1' then       
                                 data_2(1) <= data_in_buffer;
                                 end if; 
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                    SDA_out <= SDA_out;
                                                                      w <= w;
                                                                                                                            clk_stretch <= clk_stretch;
                                 when "0111011" =>
                                 if clk_response = '1' then       
                                 data_2(0) <= data_in_buffer;
                                 end if;
                                 to_adr <= to_adr;                  
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                
                                 SDA_out <= '0'; 
                                   w <= w;
                                                                                         clk_stretch <= clk_stretch;     
                   
                                 when "0111100" =>     -------- MASTER ACK
                                  w <= '1';
                                  to_adr <= to_adr;           
                                  clk_stretch <= clk_stretch; 
                                               
                                   SDA_out <= SDA_out;        
                                   redirect <= redirect;      
                                   to_redirect <= to_redirect;
                                                                    
                                 when "0111101" =>
                                 SDA_out <= '0'; 
                                 to_adr <= to_adr;           
                                 clk_stretch <= clk_stretch; 
                                  w <= w;                    
                                       
                                  redirect <= redirect;      
                                  to_redirect <= to_redirect;
                   
                   
                                                                  when "0111110" =>
                                                                  
                                                                                  ------------------------------------------------------------------
                                                                                      -- CLK STRETCHING   
                                                                     if (stretch_trigger = '1') then                  
                                                                   clk_stretch <= '1';
                                                                   elsif(clk_in = '1') then
                                                                   clk_stretch <= '0';
                                                                    end if;
                                                           -----------------------------------------------------------------------------------
                                                                  
                                                                  
                                                                  w <= '0';
                                                                  if clk_response = '1' then                   
                                                                  data_3(7) <= data_in_buffer;
                                                                  end if;
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                     SDA_out <= SDA_out;
                                                                           
                                                                                                                                                             clk_stretch <= clk_stretch;
                                                                  when "0111111" =>
                                                                  if clk_response = '1' then                     
                                                                  data_3(6) <= data_in_buffer;
                                                                  end if;
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                     SDA_out <= SDA_out;
                                                                                                       w <= w;
                                                                                                                                                             clk_stretch <= clk_stretch;
                                                                  when "1000000" =>
                                                                  if clk_response = '1' then      
                                                                  data_3(5) <= data_in_buffer;
                                                                  end if;
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                     SDA_out <= SDA_out; 
                                                                                                       w <= w;
                                                                                                                                                             clk_stretch <= clk_stretch;        
                                                                  when "1000001" =>
                                                                  if clk_response = '1' then               
                                                                  data_3(4) <= data_in_buffer; 
                                                                  end if;
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                     SDA_out <= SDA_out;
                                                                                                       w <= w;
                                                                                                                                                             clk_stretch <= clk_stretch;
                                                                  when "1000010" =>
                                                                  if clk_response = '1' then       
                                                                  data_3(3) <= data_in_buffer; 
                                                                  end if;
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                     SDA_out <= SDA_out;
                                                                                                       w <= w;
                                                                                                                                                             clk_stretch <= clk_stretch;
                                                                  when "1000011" =>
                                                                  if clk_response = '1' then       
                                                                  data_3(2) <= data_in_buffer; 
                                                                  end if;
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                     SDA_out <= SDA_out;
                                                                                                       w <= w;
                                                                                                                                                             clk_stretch <= clk_stretch;
                                                                  when "1000100" =>
                                                                  if clk_response = '1' then       
                                                                  data_3(1) <= data_in_buffer;
                                                                  end if; 
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                     SDA_out <= SDA_out;
                                                                                                       w <= w;
                                                                                                                                                             clk_stretch <= clk_stretch;
                                                                  when "1000101" =>
                                                                  if clk_response = '1' then       
                                                                  data_3(0) <= data_in_buffer;
                                                                  end if;
                                                                  to_adr <= to_adr;                  
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                       w <= w;
                                                                                                                                                             clk_stretch <= clk_stretch;
                                                                                                    
                                                                  SDA_out <= '0';      
                                                    
                                                                  when "1000110" =>     -------- MASTER ACK
                                                                   w <= '1';
                                                                   to_adr <= to_adr;           
                                                                   clk_stretch <= clk_stretch; 
                                                                       
                                                                    SDA_out <= SDA_out;        
                                                                    redirect <= redirect;      
                                                                    to_redirect <= to_redirect;
                                                                                                     
                                                                  when "1000111" =>
                                                                  SDA_out <= '0'; 
                                                                  to_adr <= to_adr;           
                                                                  clk_stretch <= clk_stretch; 
                                                                   w <= w;                    
                                                                         
                                                                   redirect <= redirect;      
                                                                   to_redirect <= to_redirect;
                                                   
                                                                                                   when "1001000" =>
                                                                                                   
                                                                                                                   ------------------------------------------------------------------
                                                                                                                       -- CLK STRETCHING   
                                                                                                      if (stretch_trigger = '1') then                  
                                                                                                    clk_stretch <= '1';
                                                                                                    elsif(clk_in = '1') then
                                                                                                    clk_stretch <= '0';
                                                                                                     end if;
                                                                                            -----------------------------------------------------------------------------------
                                                                                                   
                                                                                                   w <= '0';
                                                                                                   if clk_response = '1' then                   
                                                                                                   data_4(7) <= data_in_buffer;
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                      SDA_out <= SDA_out;
                                                                                                                                  
                                                                                                                                                                                              clk_stretch <= clk_stretch;
                                                                                                   when "1001001" =>
                                                                                                   if clk_response = '1' then                     
                                                                                                   data_4(6) <= data_in_buffer;
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                      SDA_out <= SDA_out;
                                                                                                                                        w <= w;
                                                                                                                                                                                              clk_stretch <= clk_stretch;
                                                                                                   when "1001010" =>
                                                                                                   if clk_response = '1' then      
                                                                                                   data_4(5) <= data_in_buffer;
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                      SDA_out <= SDA_out; 
                                                                                                                                        w <= w;
                                                                                                                                                                                              clk_stretch <= clk_stretch;        
                                                                                                   when "1001011" =>
                                                                                                   if clk_response = '1' then               
                                                                                                   data_4(4) <= data_in_buffer; 
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                      SDA_out <= SDA_out;
                                                                                                                                        w <= w;
                                                                                                                                                                                              clk_stretch <= clk_stretch;
                                                                                                   when "1001100" =>
                                                                                                   if clk_response = '1' then       
                                                                                                   data_4(3) <= data_in_buffer; 
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                      SDA_out <= SDA_out;
                                                                                                                                        w <= w;
                                                                                                                                                                                              clk_stretch <= clk_stretch;
                                                                                                   when "1001101" =>
                                                                                                   if clk_response = '1' then       
                                                                                                   data_4(2) <= data_in_buffer; 
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                      SDA_out <= SDA_out;
                                                                                                                                       w <= w;
                                                                                                                                                                                              clk_stretch <= clk_stretch;
                                                                                                   when "1001110" =>
                                                                                                   if clk_response = '1' then       
                                                                                                   data_4(1) <= data_in_buffer;
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                      SDA_out <= SDA_out; 
                                                                                                                                        w <= w;
                                                                                                                                                                                              clk_stretch <= clk_stretch;
                                                                                                   when "1001111" =>
                                                                                                   if clk_response = '1' then       
                                                                                                   data_4(0) <= data_in_buffer;
                                                                                                   end if;
                                                                                                   to_adr <= to_adr;                  
                                                                                                                                      redirect <= redirect;      
                                                                                                                                      to_redirect <= to_redirect;
                                                                                                                                   
                                                                                                   SDA_out <= '0'; 
                                                                                                     w <= w;
                                                                                                                                                           clk_stretch <= clk_stretch;     
                                                                                     
                                                                                                   when "1010000" =>     -------- MASTER ACK
                                                                                                    w <= '1';
                                                                                                    to_adr <= to_adr;           
                                                                                                    clk_stretch <= clk_stretch; 
                                                                                                                    
                                                                                                     SDA_out <= SDA_out;        
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                                                      
                                                                                                   when "1010001" =>
                                                                                                   SDA_out <= '0'; 
                                                                                                   to_adr <= to_adr;           
                                                                                                   clk_stretch <= clk_stretch; 
                                                                                                    w <= w;                    
                                                                                                         
                                                                                                    redirect <= redirect;      
                                                                                                    to_redirect <= to_redirect;
                  
                                                                                                    when "1010010" =>
                                                                                                    
                                                                                                                    ------------------------------------------------------------------
                                                                                                                        -- CLK STRETCHING   
                                                                                                       if (stretch_trigger = '1') then                  
                                                                                                     clk_stretch <= '1';
                                                                                                     elsif(clk_in = '1') then
                                                                                                     clk_stretch <= '0';
                                                                                                      end if;
                                                                                             -----------------------------------------------------------------------------------
                                                                                                    
                                                                                                    w <= '0';
                                                                                                    if clk_response = '1' then                    
                                                                                                    data_5(7) <= data_in_buffer;
                                                                                                    end if;
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out;
                                                                                                                                   
                                                                                                                                                                                               clk_stretch <= clk_stretch;
                                                                                                    when "1010011" =>
                                                                                                    if clk_response = '1' then                     
                                                                                                    data_5(6) <= data_in_buffer;
                                                                                                    end if;
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out;
                                                                                                                                         w <= w;
                                                                                                                                                                                               clk_stretch <= clk_stretch;
                                                                                                    when "1010100" =>
                                                                                                    if clk_response = '1' then      
                                                                                                    data_5(5) <= data_in_buffer;
                                                                                                    end if;
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out;      
                                                                                                                                         w <= w;
                                                                                                                                                                                               clk_stretch <= clk_stretch;  
                                                                                                    when "1010101" =>
                                                                                                    if clk_response = '1' then               
                                                                                                    data_5(4) <= data_in_buffer;
                                                                                                    end if; 
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out;
                                                                                                                                         w <= w;
                                                                                                                                                                                               clk_stretch <= clk_stretch;
                                                                                                    when "1010110" =>
                                                                                                    if clk_response = '1' then       
                                                                                                    data_5(3) <= data_in_buffer; 
                                                                                                    end if;
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out;
                                                                                                                                         w <= w;
                                                                                                                                                                                               clk_stretch <= clk_stretch;
                                                                                                    when "1010111" =>
                                                                                                    if clk_response = '1' then       
                                                                                                    data_5(2) <= data_in_buffer;
                                                                                                    end if;
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out; 
                                                                                                                                         w <= w;
                                                                                                                                                                                               clk_stretch <= clk_stretch;
                                                                                                    when "1011000" =>
                                                                                                    if clk_response = '1' then       
                                                                                                    data_5(1) <= data_in_buffer;
                                                                                                    end if; 
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out;
                                                                                                                                         w <= w;
                                                                                                                                                                                               clk_stretch <= clk_stretch;
                                                                                                    when "1011001" =>
                                                                                                    if clk_response = '1' then       
                                                                                                    data_5(0) <= data_in_buffer;
                                                                                                    end if;
                                                                                                    to_adr <= to_adr;                  
                                                                                                                                       redirect <= redirect;      
                                                                                                                                       to_redirect <= to_redirect;
                                                                                                                                       SDA_out <= SDA_out;
                                                                                                                                         w <= w;
                                                                                                                                                                                               clk_stretch <= clk_stretch;
                                                                                                    SDA_out <= '0';        
                                                                                                    
                                                                                                    when "1011010" =>     -------- MASTER ACK
                                                                                                    w <= '1';
                                                                                                    to_adr <= to_adr;           
                                                                                                    clk_stretch <= clk_stretch; 
                                                                                                                    
                                                                                                     SDA_out <= SDA_out;        
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                                      
                                                                                                    when "1011011" =>
                                                                                                    SDA_out <= '0'; 
                                                                                                    to_adr <= to_adr;           
                                                                                                    clk_stretch <= clk_stretch; 
                                                                                                     w <= w;                    
                                                                                                          
                                                                                                     redirect <= redirect;      
                                                                                                     to_redirect <= to_redirect;
                                                                                                    
                                                                                                                      
                                                                                                     when "1011100" =>
                                                                                                     
                                                                                                                     ------------------------------------------------------------------
                                                                                                                         -- CLK STRETCHING   
                                                                                                        if (stretch_trigger = '1') then                  
                                                                                                      clk_stretch <= '1';
                                                                                                      elsif(clk_in = '1') then
                                                                                                      clk_stretch <= '0';
                                                                                                       end if;
                                                                                              -----------------------------------------------------------------------------------
                                                                                                     
                                                                                                     w <= '0';
                                                                                                     if clk_response = '1' then                    
                                                                                                     data_6(7) <= data_in_buffer;
                                                                                                     end if;
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        SDA_out <= SDA_out;
                                                                                                                             
                                                                                                                            
                                                                                                                                                                                                clk_stretch <= clk_stretch;
                                                                                                     when "1011101" =>
                                                                                                     if clk_response = '1' then                     
                                                                                                     data_6(6) <= data_in_buffer;
                                                                                                     end if;
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        SDA_out <= SDA_out;
                                                                                                                                          w <= w;
                                                                                                                                                                                                clk_stretch <= clk_stretch;
                                                                                                     when "1011110" =>
                                                                                                     if clk_response = '1' then      
                                                                                                     data_6(5) <= data_in_buffer;
                                                                                                     end if;  
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        SDA_out <= SDA_out;  
                                                                                                                                       w <= w;
                                                                                                                                     
                                                                                                                                                                                                clk_stretch <= clk_stretch;     
                                                                                                     when "1011111" =>
                                                                                                     if clk_response = '1' then               
                                                                                                     data_6(4) <= data_in_buffer;
                                                                                                     end if; 
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        SDA_out <= SDA_out;
                                                                                                                                        w <= w;                   
                                                                                                                                        clk_stretch <=clk_stretch;
                                                                                                     when "1100000" =>
                                                                                                     if clk_response = '1' then       
                                                                                                     data_6(3) <= data_in_buffer; 
                                                                                                     end if;
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        SDA_out <= SDA_out;
                                                                                                                                        w <= w;                   
                                                                                                                                        clk_stretch <=clk_stretch;
                                                                                                     when "1100001" =>
                                                                                                     if clk_response = '1' then       
                                                                                                     data_6(2) <= data_in_buffer;
                                                                                                     end if;
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        SDA_out <= SDA_out; 
                                                                                                                                        w <= w;                   
                                                                                                                                        clk_stretch <=clk_stretch;
                                                                                                     when "1100010" =>
                                                                                                     if clk_response = '1' then       
                                                                                                     data_6(1) <= data_in_buffer;
                                                                                                     end if;
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        SDA_out <= SDA_out; 
                                                                                                                                        w <= w;                   
                                                                                                                                        clk_stretch <=clk_stretch;
                                                                                                     when "1100011" =>
                                                                                                     if clk_response = '1'
                                                                                                     
                                                                                                      then       
                                                                                                     data_6(0) <= data_in_buffer;
                                                                                                     end if;
                                                                                                     to_adr <= to_adr;                  
                                                                                                                                        redirect <= redirect;      
                                                                                                                                        to_redirect <= to_redirect;
                                                                                                                                        
                                                                                                     SDA_out <= '1';
                                                                                                     w <= w;                   
                                                                                                     clk_stretch <=clk_stretch;        
                                                                                                     
                                                                                                     when "1100100" =>     -------- MASTER noACK
                                                                                                     w <= '1';
                                                                                                     to_adr <= to_adr;           
                                                                                                     clk_stretch <= clk_stretch; 
                                                                                                            
                                                                                                      SDA_out <= SDA_out;        
                                                                                                      redirect <= redirect;      
                                                                                                      to_redirect <= to_redirect;
                                                                                                                       
                                                                                                     when "1100101" =>
                                                                                                     SDA_out <= '1'; 
                                                                                                     to_adr <= to_adr;           
                                                                                                     clk_stretch <= clk_stretch; 
                                                                                                      w <= w;                    
                                                                                                            
                                                                                                      redirect <= redirect;      
                                                                                                      to_redirect <= to_redirect;
                                                                                                     
                                                                                                     
                                                                                                     when "1100110" =>
                                                                                                     
                                                                                                     if(clk_in = '1') and  (clk_counter > x"0EB") then
                                                                                                       SDA_out <= '0';
                                                                                                       else
                                                                                                       SDA_out <= SDA_out;
                                                                                                       end if;
                                                                                                       to_adr <= to_adr;           
                                                                                                       clk_stretch <= clk_stretch; 
                                                                                                        w <= w;                    
                                                                                                        
                                                                                                        redirect <= redirect;      
                                                                                                        to_redirect <= to_redirect;
                                                                                                     
                                                                                                     when "1100111" =>
                                                                                                     redirect <= "001";
                                                                                                     to_redirect <= '1';      
                                                    
                                                                                     
                                                                                            to_adr <= to_adr;           
                                                                                                     clk_stretch <= clk_stretch; 
                                                                                                      w <= w;                    
                                                                                                      SDA_out <= SDA_out;        
                                                                                                
                   
                   
                   
                   
                   
                   
                   
                              
                   
                   when others =>                    
                   SDA_out <= SDA_out;        
                   w <= w;
                   clk_stretch <= clk_stretch;
                   redirect <= redirect;
                   to_redirect <= to_redirect;
                   to_adr <= to_adr;
                   
                   end case;
                   
                   else
                   clk_stretch <= '0';
                   SDA_out <= '1';
                   w <= '1';
                  -- clk_w <= '1';
    
    end if;
    
 --    if run_I2C = '0' then
       
  ---     run_I2C <= '1' after 30ns;
   --    end if; 


end if;
end process;
 


process(clk_stretch,clk_in)
begin
if (((clk_stretch = '1') and (clk_in = '1'))or(clk_stretch = '0')) then
clk_w <= '1';

else
clk_w <= '0';
end if;
end process;



process(s00_axi_aclk,init_state)
begin
case (init_state) is

when "0110010" =>
send_data_1 <= '1';
send_data_2 <= '0';
send_data_6 <= '0';     
 when "0111100" =>
send_data_1 <= '0';
send_data_2 <= '1';
send_data_6 <= '0';
when "1100100" =>
send_data_1 <= '0';
send_data_2 <= '0';
send_data_6 <= '1';
when others =>
send_data_1 <= '0';
send_data_2 <= '0';
send_data_6 <= '0';
end case;
end process;


end arch_imp;
