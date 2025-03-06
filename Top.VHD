library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_top is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        rx          : in  STD_LOGIC;
        tx          : out STD_LOGIC
    );
end uart_top;

architecture Behavioral of uart_top is
    
    -- UART components
    COMPONENT uart_rx
    PORT(
        clk : IN std_logic;
        rst : IN std_logic;
        rx : IN std_logic;
        parity_en : in std_logic := '1';
        parity_type : in std_logic := '0';
        rx_data_out : OUT std_logic_vector(7 downto 0);
        parity_error: out std_logic := '0';
        valid : OUT std_logic
    );
    END COMPONENT;

    COMPONENT uart_tx
    PORT(
        clk : IN std_logic;
        rst : IN std_logic;
        trig : IN std_logic;
        tx_data_in : IN std_logic_vector(7 downto 0);
        tx_active : OUT std_logic;
        parity_en : IN std_logic := '1';
        parity_type : IN std_logic := '0';
        tx_done : OUT std_logic;
        tx_out : OUT std_logic
    );
    END COMPONENT;

    -- Internal signals
    signal rx_data_out : std_logic_vector(7 downto 0);
    signal parity_error : std_logic;
    signal valid : std_logic;
    signal tx_active : std_logic;
    signal tx_done : std_logic;
    signal tx_trig : std_logic := '0';
    


begin
    
    -- Instantiate UART components
    uart_receiver: uart_rx
    port map(
        clk => clk,
        rst => rst,
        rx => rx,
        parity_en => '1',
        parity_type => '0',
        rx_data_out => rx_data_out,
        parity_error => parity_error,
        valid => valid
    );

    uart_transmitter: uart_tx
    port map(
        clk => clk,
        rst => rst,
        trig => tx_trig,
        tx_data_in => DATA_7F,
        tx_active => tx_active,
        parity_en => '1',
        parity_type => '0',
        tx_done => tx_done,
        tx_out => tx
    );

end Behavioral;
