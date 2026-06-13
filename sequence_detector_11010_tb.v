/*  Testbench máquina de estados detector de secuencia

    Autores:
    Victoria Fierro Aveytia A01247288
    Blanca Abigail Mendez Delgado A01247329

    Descripcion:
    En el siguiente codigo se realiza comprueba el funcionamiento
    de una maquina de estados, que busca detectar la secuencia 11010. 
*/

module sequence_detector_11010_tb();
    reg sequence_in, clk, reset;  // se establecen los inputs a probar como registros
    wire match_sequence;  // se establecen los outputs a probar como wire

sequence_detector_11010 DUT(     // establecemos las variable del diseño 
    .sequence_in(sequence_in),   // en el tb como: .variabletb(variable del diseño)
    .clk(clk),
    .reset(reset),
    .match_sequence(match_sequence)
);

always #5 clk = ~clk; // cuantos tiempos se utilizaran en clk = 1, y cuantos en clk = 0

initial  // se prueban posibles configuraciones de la maquina de estados
begin
    sequence_in = 0;  // inicializamos todas los inputs en 0
    clk = 0;
    reset = 0;

    #20; // probamos el reset en 20 ciclos del reloj
    reset = 1; 
    #20        
    reset = 0;

    #10; // se le dan 10 ciclos de reloj a cada prueba
    sequence_in = 1;  // se utiliza la secuencia de prueba sugerida
    #10;
    sequence_in = 1;
    #10;
    sequence_in = 0;
    #10;
    sequence_in = 1;
    #10;
    sequence_in = 1;
    #10;
    sequence_in = 1;
    #10;
    sequence_in = 0;
    #10;
    sequence_in = 1;
    #10;
    sequence_in = 0;
    #10;
    sequence_in = 1;
    #10;
    sequence_in = 1;
    #10;
    sequence_in = 0;
    #10;
    sequence_in = 1;
    $finish;
end

initial
begin
    $monitor("Cambios en estado o señales");
    $monitor("Entrada = %d, Salida = %d", sequence_in, match_sequence);

initial
begin
    $dumpfile("sequence_detector_11010.vcd");  // genera un archivo para las señales analizadas
    $dumpvars(0,sequence_detector_11010_tb);  // establece en que tiempo empieza la simulación, y las variables a utilizar
end

endmodule