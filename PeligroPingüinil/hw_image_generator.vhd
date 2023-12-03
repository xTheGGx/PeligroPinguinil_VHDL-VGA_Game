--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hw_image_generator IS
  GENERIC(
    pixels_y :  INTEGER := 640;   --row that first color will persist until
    pixels_x :  INTEGER := 480);  --column that first color will persist until
  PORT(
    disp_ena :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row      :  IN   INTEGER;    --row pixel coordinate
    column   :  IN   INTEGER;    --column pixel coordinate
    red      :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);  --red magnitude output to DAC
    green    :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);  --green magnitude output to DAC
    blue     :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0); --blue magnitude output to DAC
	 dipsw	 :  IN	STD_LOGIC_VECTOR(2 DOWNTO 0);
	 reloj	 :	 IN   STD_LOGIC);
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
SIGNAL x,y,x1,x2,X3,X4 : INTEGER RANGE 0 TO 600;
SIGNAL colliderBot, colliderTop, colliderLeft, colliderRight : INTEGER RANGE 0 TO 600;
SIGNAL colliderPiececitosBot, colliderPiececitosTop, colliderPiececitosLeft, colliderPiececitosRight : INTEGER RANGE 0 TO 600;
SIGNAL colliderBearBot, colliderBearTop, colliderBearLeft, colliderBearRight : INTEGER RANGE 0 TO 600;
SIGNAL colliderTree1Bot, colliderTree1Top, colliderTree1Left, colliderTree1Right : INTEGER RANGE 0 TO 600;
SIGNAL colliderTree2Bot, colliderTree2Top, colliderTree2Left, colliderTree2Right : INTEGER RANGE 0 TO 600;
SIGNAL colliderTree3Bot, colliderTree3Top, colliderTree3Left, colliderTree3Right : INTEGER RANGE 0 TO 600;
SIGNAL colliderTree4Bot, colliderTree4Top, colliderTree4Left, colliderTree4Right : INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk1_1Bot, colliderTrunk1_1Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk1_2Bot, colliderTrunk1_2Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk1_3Bot, colliderTrunk1_3Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk1_4Bot, colliderTrunk1_4Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk1_Left, colliderTrunk1_Right: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk2_1Bot, colliderTrunk2_1Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk2_2Bot, colliderTrunk2_2Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk2_3Bot, colliderTrunk2_3Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk2_Left, colliderTrunk2_Right: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk3_1Bot, colliderTrunk3_1Top: INTEGER RANGE 0 TO 600;
SIGNAL colliderTrunk3_Left, colliderTrunk3_Right: INTEGER RANGE 0 TO 600;
SIGNAL colliderIgluBot, colliderIgluTop, colliderIgluLeft, colliderIgluRight : INTEGER RANGE 0 TO 600;
SIGNAL gameOver: std_logic; --TODO: implementar cambio de pantallas con banderas gameOver y endGame.
SIGNAL endGame : std_logic;
SIGNAL trunkFlag: std_logic := '0';
SIGNAL trunk2Flag: std_logic := '0';
SIGNAL trunk3Flag: std_logic := '0';
BEGIN

PROCESS(disp_ena, row, column)
BEGIN
IF (disp_ena = '1') THEN
	IF ((row > -5 and row < 10) and (column > -5 and column < 645)) THEN --RIO SUPERIOR
		red <= ("000");
		green <= ("101");
		blue <= ("111");
	ELSIF ((row > 470 and row < 485) and (column > -5 and column < 645)) THEN --RIO INFERIOR
		red <= ("000");
		green <= ("101");
		blue <= ("111");
	ELSIF ((row > -5 and row < 485) and (column > 630 and column < 645)) THEN --RIO DERECHA
		red <= ("000");
		green <= ("101");
		blue <= ("111");
	ELSIF ((row > 65 and row < 485) and (column > -5 and column < 10)) THEN --RIO IZQUIERDA
		red <= ("000");
		green <= ("101");
		blue <= ("111");
		
	ELSIF ((row > 190 and row < 290) and (column > 570 and column < 630)) THEN --IGLÚ
		red <= ("111");
		green <= ("111");
		blue <= ("111");
	ELSIF ((row > 215 and row < 265) and (column > 555 and column < 571)) THEN --IGLÚPUERTA
		red <= ("111");
		green <= ("111");
		blue <= ("111");		
				
	ELSIF ((row > 20 and row < 31) and (column > 175 and column < 185)) THEN --ARBOL1
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 30 and row < 41) and (column > 170 and column < 190)) THEN --ARBOL1
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 40 and row < 51) and (column > 165 and column < 195)) THEN --ARBOL1
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 50 and row < 61) and (column > 160 and column < 200)) THEN --ARBOL1
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 60 and row < 70) and (column > 155 and column < 205)) THEN --ARBOL1
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 69 and row < 85) and (column > 175 and column < 185)) THEN --ARBOL1
		red <= ("110");
		green <= ("100");
		blue <= ("001");
		
	ELSIF ((row > 120 and row < 131) and (column > 210 and column < 220)) THEN --ARBOL2
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 130 and row < 141) and (column > 205 and column < 225)) THEN --ARBOL2
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 140 and row < 151) and (column > 200 and column < 230)) THEN --ARBOL2
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 150 and row < 161) and (column > 195 and column < 235)) THEN --ARBOL2
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 160 and row < 170) and (column > 190 and column < 240)) THEN --ARBOL2
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 169 and row < 185) and (column > 210 and column < 220)) THEN --ARBOL2
		red <= ("110");
		green <= ("100");
		blue <= ("001");

	ELSIF ((row > 270 and row < 281) and (column > 210 and column < 220)) THEN --ARBOL3
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 280 and row < 291) and (column > 205 and column < 225)) THEN --ARBOL3
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 290 and row < 301) and (column > 200 and column < 230)) THEN --ARBOL3
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 300 and row < 311) and (column > 195 and column < 235)) THEN --ARBOL3
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 310 and row < 320) and (column > 190 and column < 240)) THEN --ARBOL3
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 319 and row < 335) and (column > 210 and column < 220)) THEN --ARBOL3
		red <= ("110");
		green <= ("100");
		blue <= ("001");	
	
	ELSIF ((row > 370 and row < 381) and (column > 245 and column < 255)) THEN --ARBOL4
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 380 and row < 391) and (column > 240 and column < 260)) THEN --ARBOL4
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 390 and row < 401) and (column > 235 and column < 265)) THEN --ARBOL4
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 400 and row < 411) and (column > 230 and column < 270)) THEN --ARBOL4
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 410 and row < 420) and (column > 225 and column < 275)) THEN --ARBOL4
		red <= ("100");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > 419 and row < 435) and (column > 245 and column < 255)) THEN --ARBOL4
		red <= ("110");
		green <= ("100");
		blue <= ("001");
		
	ELSIF ((row > x+25 and row < x+32) and (column > y+9 and column < y+22)) THEN --PICO
		red <= ("111");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > x+20 and row < x+26) and (column > y+7 and column < y+10)) THEN --OJO 1
		red <= ("000");
		green <= ("000");
		blue <= ("000");
	ELSIF ((row > x+15 and row < x+32) and (column > y+3 and column < y+17)) THEN --CABEZA
		red <= ("000");
		green <= ("110");
		blue <= ("111");
	ELSIF ((row > x+50 and row < x+57) and (column > y-1 and column < y+10)) THEN --PATA 1
		red <= ("111");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > x+50 and row < x+57) and (column > y+14 and column < y+25)) THEN --PATA 2
		red <= ("111");
		green <= ("111");
		blue <= ("000");
	ELSIF ((row > x+35 and row < x+53) and (column > y+3 and column < y+17)) THEN --PECHO
		red <= ("111");
		green <= ("111");
		blue <= ("111");
	ELSIF ((row > x+30 and row < x+40) and (column > y+5 and column < y+15)) THEN --PECHO ARRIBA
		red <= ("111");
		green <= ("111");
		blue <= ("111");
	ELSIF ((row > x+30 and row < x+55) and (column > y and column < y+20)) THEN --CUERPO
		red <= ("000");
		green <= ("110");
		blue <= ("111");

	ELSIF ((row > x1-30 and row < x1+70) and (column > 102 and column < 128)) THEN --TRONCO HACIA ABAJO 1
		red <= ("110");
		green <= ("100");
		blue <= ("000");
	ELSIF ((row > x1-175 and row < x1-75) and (column > 102 and column < 128)) THEN --TRONCO HACIA ABAJO 2
		red <= ("110");
		green <= ("100");
		blue <= ("000");
	ELSIF ((row > x1-320 and row < x1-220) and (column > 102 and column < 128)) THEN --TRONCO HACIA ABAJO 3
		red <= ("110");
		green <= ("100");
		blue <= ("000");
	ELSIF ((row > x1-465 and row < x1-365) and (column > 102 and column < 128)) THEN --TRONCO HACIA ABAJO 4
		red <= ("110");
		green <= ("100");
		blue <= ("000");

	ELSIF ((row > x2-30 and row < x2+70) and (column > 302 and column < 328)) THEN --TRONCO HACIA ARRIBA 1
		red <= ("110");
		green <= ("100");
		blue <= ("000");
	ELSIF ((row > x2+170 and row < x2+270) and (column > 302 and column < 328)) THEN --TRONCO HACIA ARRIBA 2
		red <= ("110");
		green <= ("100");
		blue <= ("000");
	ELSIF ((row > x2+370 and row < x2+470) and (column > 302 and column < 328)) THEN --TRONCO HACIA ARRIBA 3
		red <= ("110");
		green <= ("100");
		blue <= ("000");
		
	ELSIF ((row > x3-30 and row < x3+70) and (column > 452 and column < 478)) THEN --TRONCO HACIA ABAJO 2.1
		red <= ("110");
		green <= ("100");
		blue <= ("000");
	ELSIF ((row > x3-465 and row < x3-365) and (column > 452 and column < 478)) THEN --TRONCO HACIA ABAJO 2.2
		red <= ("110");
		green <= ("100");
		blue <= ("000");

	ELSIF ((row > -5 and row < 480) and (column > 100 and column < 130)) THEN --RIO 1
		red <= ("000");
		green <= ("101");
		blue <= ("111");
	ELSIF ((row > -5 and row < 480) and (column > 300 and column < 330)) THEN --RIO 2
		red <= ("000");
		green <= ("101");
		blue <= ("111");
	ELSIF ((row > -5 and row < 480) and (column > 450 and column < 480)) THEN --RIO 3
		red <= ("000");
		green <= ("101");
		blue <= ("111");

	ELSIF ((row > X4+90 and row < X4+95) and (column > 386 and column < 394)) THEN --OSOPOLARNARIZ
		red <= ("000");
		green <= ("000");
		blue <= ("000");
	ELSIF ((row > X4+76 and row < X4+82) and (column > 383 and column < 386)) THEN --OSOPOLAROJO1
		red <= ("000");
		green <= ("000");
		blue <= ("000");		
	ELSIF ((row > X4+76 and row < X4+82) and (column > 394 and column < 397)) THEN --OSOPOLAROJO2
		red <= ("000");
		green <= ("000");
		blue <= ("000");			
	ELSIF ((row > X4+15 and row < X4+75) and (column > 370 and column < 410)) THEN --OSOPOLARCUERPO
		red <= ("111");
		green <= ("111");
		blue <= ("111");	
	ELSIF ((row > X4+74 and row < X4+95) and (column > 375 and column < 405)) THEN --OSOPOLARCABEZA
		red <= ("111");
		green <= ("111");
		blue <= ("111");
	ELSIF ((row > X4+8 and row < X4+16) and (column > 385 and column < 395)) THEN --OSOPOLARCOLA
		red <= ("111");
		green <= ("111");
		blue <= ("111");	

	ELSE
		red <= ("110"); --FONDO
		green <= ("111");
		blue <= ("111");
	END IF;
ELSE
	red <= ("000");
	green <= ("000");
	blue <= ("000");
END IF;

END PROCESS;
	
PROCESS (reloj, dipsw)
BEGIN
	IF (reloj'event AND reloj = '1') THEN
		IF (dipsw(2)='1' AND dipsw(1)='0' AND dipsw(0)='0') THEN --DETENER
			IF (y>0 AND y<640) THEN
				x<=x;
				y<=y;
			ELSE
				y<=1;
			END IF;
		ELSIF (dipsw(2)='0' AND dipsw(1)='0' AND dipsw(0)='0') THEN --AVANZAR
			IF (y>0 AND y<605) THEN
				x<=x;
				y<=y+1;
			ELSE
				y<=1;
			END IF;
		ELSIF (dipsw(1)='0' AND dipsw(0)='1') THEN --RETROCEDER
			IF (y>0 AND y<605) THEN
				x<=x;
				y<=y-1;
			ELSE
				y<=1;
			END IF;
		ELSIF(dipsw(1)='1' AND dipsw(0)='0') THEN --ARRIBA
			IF (x>0 AND x<480) THEN
				x<=x-1;
				y<=y;
			ELSE
				x<=1;
			END IF;
		ELSIF (dipsw(1)='1' AND dipsw(0)='1') THEN --ABAJO
			IF (x>0 AND x<480) THEN
				x<=x+1;
				y<=y;
			ELSE
				x<=1;
			END IF;
		END IF;
		
			IF (x1>0 AND x1<480) THEN --PRIMEROS TRONCOS HACIA ARRIBA
				x1<=x1+1;
			ELSE
				x1<=335;
			END IF;
			IF (x2>0 AND x2<600) THEN --TRONCOS HACIA ABAJO
				x2<=x2-1;
			ELSE
				x2<=200;
			END IF;
			IF (x3>0 AND x3<480) THEN --TRONCOS HACIA ABAJO
				x3<=x3+1;
			ELSE
				x3<=45;
			END IF;
			
			IF (x4>0 AND x4<450) THEN --OSOPOLAR
				x4<=x4+2;
			ELSE
				x4<=10;
			END IF;	
		--============  M A N E J O D E C O L I S I O N E S  ==========
		colliderTop <= x + 30;
        colliderBot <= x + 40;
        colliderLeft <= y + 3;
        colliderRight <= y + 17;
        colliderBearTop <= x4 + 15 ;
        colliderBearBot <= x4 + 75;
        colliderBearLeft <= 370 ;
        colliderBearRight <= 410 ;
		-- Oso polar
        if colliderLeft >= colliderBearLeft then
            if colliderRight <= colliderBearRight  then
                if colliderTop >= colliderBearTop then
                    if colliderBot <= colliderBearBot then
                        x <= 0; 
                        y <= 0;
                        gameOver <= '1';
                    end if;
                end if;
            end if;
        end if;
        -- Árboles
	colliderTree1Top <= 30 ;
    colliderTree1Bot <= 85;
    colliderTree1Left <= 170;
    colliderTree1Right <= 190;

        if colliderLeft >= colliderTree1Left then
            if colliderRight <= colliderTree1Right  then
                if colliderTop >= colliderTree1Top then
                    if colliderBot <= colliderTree1Bot then
                        x <= 0; 
                        y <= 0;
                        gameOver <= '1';
                    end if;
                end if;
            end if;
        end if;

    colliderTree2Top <= 130 ;
    colliderTree2Bot <= 185;
    colliderTree2Left <= 205;
    colliderTree2Right <= 225;

        if colliderLeft >= colliderTree2Left then
            if colliderRight <= colliderTree2Right  then
                if colliderTop >= colliderTree2Top then
                    if colliderBot <= colliderTree2Bot then
                        x <= 0; 
                        y <= 0;
                        gameOver <= '1';
                    end if;
                end if;
            end if;
        end if;
    
    colliderTree3Top <= 280 ;
    colliderTree3Bot <= 335;
    colliderTree3Left <= 205;
    colliderTree3Right <= 225;

        if colliderLeft >= colliderTree3Left then
            if colliderRight <= colliderTree3Right  then
                if colliderTop >= colliderTree3Top then
                    if colliderBot <= colliderTree3Bot then
                        x <= 0; 
                        y <= 0;
                        gameOver <= '1';
                    end if;
                end if;
            end if;
        end if;

    colliderTree4Top <= 380 ;
    colliderTree4Bot <= 435;
    colliderTree4Left <= 240;
    colliderTree4Right <= 260;

        if colliderLeft >= colliderTree4Left then
            if colliderRight <= colliderTree4Right  then
                if colliderTop >= colliderTree4Top then
                    if colliderBot <= colliderTree4Bot then
                        x <= 0; 
                        y <= 0;
                        gameOver <= '1';
                    end if;
                end if;
            end if;
        end if;
    --Troncos
    colliderPiececitosTop <= x + 50;
    colliderPiececitosBot <= x + 57;
    colliderPiececitosLeft <= y + 1;
    colliderPiececitosRight <= y + 23;
    -----------------------------------------
    colliderTrunk1_Left <= 100;
    colliderTrunk1_Right <= 130;

    colliderTrunk1_1Top <= x1 - 30;
    colliderTrunk1_1Bot <= x1 + 70;

    colliderTrunk1_2Top <= x1 - 175;
    colliderTrunk1_2Bot <= x1 - 75;

    colliderTrunk1_3Top <= x1 - 320;
    colliderTrunk1_3Bot <= x1 - 220;

    colliderTrunk1_4Top <= x1 - 465;
    colliderTrunk1_4Bot <= x1 - 365;

    if colliderPiececitosLeft >= colliderTrunk1_Left then
        if colliderPiececitosRight <= colliderTrunk1_Right  then
            
            trunkFlag <= '0';

            if colliderPiececitosTop >= colliderTrunk1_1Top then
                if colliderPiececitosBot <= colliderTrunk1_1Bot then 
                    trunkFlag <= '1';
                end if;
            end if;

            if colliderPiececitosTop >= colliderTrunk1_2Top then
                if colliderPiececitosBot <= colliderTrunk1_2Bot then
                    trunkFlag <= '1';
                end if;
            end if;

            if colliderPiececitosTop >= colliderTrunk1_3Top then
                if colliderPiececitosBot <= colliderTrunk1_3Bot then
                    trunkFlag <= '1';
                end if;
            end if;

            if colliderPiececitosTop >= colliderTrunk1_4Top then
                if colliderPiececitosBot <= colliderTrunk1_4Bot then
                    trunkFlag <= '1';
                end if;
            end if;

            if trunkFlag = '0' then
                x <= 0;
                y <= 0;
                gameOver <= '1';
            end if;
        
        end if;
    end if;
----------------------------------------------
    colliderTrunk2_Left <= 300;
    colliderTrunk2_Right <= 330;

    colliderTrunk2_1Top <= x2 - 30;
    colliderTrunk2_1Bot <= x2 + 70;

    colliderTrunk2_2Top <= x2 + 170;
    colliderTrunk2_2Bot <= x2 + 270;

    colliderTrunk2_3Top <= x2 + 370;
    colliderTrunk2_3Bot <= x2 + 470;


    if colliderPiececitosLeft >= colliderTrunk2_Left then
        if colliderPiececitosRight <= colliderTrunk2_Right  then
            
            trunk2Flag <= '0';

            if colliderPiececitosTop >= colliderTrunk2_1Top then
                if colliderPiececitosBot <= colliderTrunk2_1Bot then 
                    trunk2Flag <= '1';
                end if;
            end if;

            if colliderPiececitosTop >= colliderTrunk2_2Top then
                if colliderPiececitosBot <= colliderTrunk2_2Bot then
                    trunk2Flag <= '1';
                end if;
            end if;

            if colliderPiececitosTop >= colliderTrunk2_3Top then
                if colliderPiececitosBot <= colliderTrunk2_3Bot then
                    trunk2Flag <= '1';
                end if;
            end if;

            if trunk2Flag = '0' then
                x <= 0;
                y <= 0;
                gameOver <= '1';
            end if;
        
        end if;
    end if;
---------------------------------
    colliderTrunk3_Left <= 450;
    colliderTrunk3_Right <= 480;

    colliderTrunk3_1Top <= x3 - 30;
    colliderTrunk3_1Bot <= x3 + 70;


    if colliderPiececitosLeft >= colliderTrunk3_Left then
        if colliderPiececitosRight <= colliderTrunk3_Right  then
            
            trunk3Flag <= '0';

            if colliderPiececitosTop >= colliderTrunk3_1Top then
                if colliderPiececitosBot <= colliderTrunk3_1Bot then 
                    trunk3Flag <= '1';
                end if;
            end if;

            if trunk3Flag = '0' then
                x <= 0;
                y <= 0;
                gameOver <= '1';
            end if;
        
        end if;
    end if;
    --Iglu

	 colliderIgluTop <= 190 ;
    colliderIgluBot <= 290;
    colliderIgluLeft <= 570;
    colliderIgluRight <= 600;
    
    if colliderLeft >= colliderIgluLeft then
        if colliderRight <= colliderIgluRight  then
            if colliderTop >= colliderIgluTop then
                if colliderBot <= colliderIgluBot then
                    x <= 0; 
                    y <= 0;
                    endGame <= '1'; --Se finaliza el juego cuando se llega al Iglú
                end if;
            end if;
        end if;
    end if;

        END IF;
	END PROCESS;	
	
END behavior;