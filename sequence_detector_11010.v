/*  Máquina de estados detector de secuencia

    Autores:
    Victoria Fierro Aveytia A01247288
    Blanca Abigail Méndez Delgado A01247329

    Descripcion:
    En el siguiente codigo se realiza una maquina de estados que busca
    detectar la secuencia 11010, con una salida final de 1 
    cuando se completa la secuencia.
*/

module sequence_detector_11010(   // inicializacion de todas las variables
    input sequence_in, clk, reset,
    output reg match_sequence
);

parameter A = 3'b000,  // establecemos parametros de 3 bits para poder
          B = 3'b001,  // representar los 6 estados que necesitamos
          C = 3'b010,
          D = 3'b011,
          E = 3'b100,
          F = 3'b101;

reg [2:0] current_state, next_state;  // deben de tener la misma cantidad de bits que los parametros

always @(posedge clk or posedge reset)
begin 
    if(reset)  // valor inicial al que se regresa en caso de reset
        current_state <= A;
    else      // valor de current_state cuando no hay reset
        current_state <= next_state;
end 

always @(*)  // maquina de estados
begin
    match_sequence = 0;  // se inicializa en 0 y solo tendra un cambio cuando se complete la secuencia

    case(current_state)  // condiciones de cambio de estado

        A:   // se busca obtener 1 para seguir
        begin
            if(sequence_in == 1)
                next_state = B;  // 1
            else
                next_state = A;
        end

        B:   // se busca obtener 1 para seguir
        begin
            if(sequence_in == 1)
                next_state = C;  // 11
            else
                next_state = B;
        end

        C:    // se busca obtener 0 para seguir
        begin
           if(sequence_in == 0)
                next_state = D;  // 110
            else
                next_state = B; // se regresa a B (1)
        end

        D:    // se busca obtener 1 para seguir
        begin
            if(sequence_in == 1)
                next_state = E;  // 1101
            else
                next_state = A; // se regresa a A (0)
        end

        E:    // se busca obtener 0 para seguir
        begin
            if(sequence_in == 0)
                next_state = F;  // 11010
            else
                next_state = B; // se regresa a B (1)
        end

        F:   // se completa la secuencia y se decide a donde regresar
        begin
            if(sequence_in == 0)
            begin
                match_sequence = 1;  // salida = 1
                next_state = A;      // reinicia la secuencia en A (0)
            end
            else
                next_state = B;      // reinicia la secuencia en B (1)
        end

        default:  // estado en el que automaticamente se inicializa 
            next_state = A;
    endcase
end 

endmodule 