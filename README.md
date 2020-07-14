# Imágenes térmicas Con Cámaras Web
Este es un proyecto, desarrollado para el curso de óptica y acústica de la Universidad Nacional de Colombia, para identificar la temperatura de las personas mediante 
una foto con cámara web sin el filtro Infrarrojo. Esto surge bajo la expectativa de poder, de forma económica, identificar la temperatura de las personas debido a la pandemia que estamos viviendo
con el objetivo de disminuir el contacto de las personas al momento de tener que entrar a un sitio.\
**Advertencia:** El proyecto no funcionó. Así que se mostrará el desarrollo de este y las razones por las cuales las cámaras web no lo permiten.
## Descripción
Este proyecto se desarrolló en MatLab 2019b básico y adicionalmente se utilizó la libreria *Image Processing Toolbox*. Para el desarrollo del proyecto no es necesario clonar todo el repositorio. Los códigos necesarios se encuentran en la carpeta de ***Segmentacion_termica_para_objetos*** y ***Segmentacion_termica_para_personas***.
## Ejecución ⚙️
Los códigos son bastante amigables para quien quiera utilizarlos, lo único que tiene que hacer es compilarlos y escribir el nombre de las imágenes con y sin filtro junto con su extensión. Compile el código y asegurese que las imágenes que quiere analizar esten en la misma carpeta. Le aparecerá lo siguiente en la ventana de comando:
![alt text](https://github.com/ljcaviedesb/Imagenes-Termicas/blob/master/1.JPG)
En nuestro caso vamos a utilizar una imagen que nombramos *color.jpg*, simplemente lo escribe, enter y pone la imágen que no tiene el filtro IR
![alt text](https://github.com/ljcaviedesb/Imagenes-Termicas/blob/master/2.JPG)
A continuación le aparecerá una imagen con tres sub imágenes, en la tercera va a seleccionar el área que quiere analizar
![alt text](https://github.com/ljcaviedesb/Imagenes-Termicas/blob/master/3.png)
Una vez recortado, en la misma imágen aparecerá la cuarta subimágen en donde se traza una linea o cuantas quiera para ver la intensidad de cada uno de los pixeles a lo largo de la linea trazada.
![alt text](https://github.com/ljcaviedesb/Imagenes-Termicas/blob/master/4.png)
El perfil de intensidades
![alt text](https://github.com/ljcaviedesb/Imagenes-Termicas/blob/master/Segmentacion%20Termica%20objetos/Cautín/Profile_fig2.jpg)
y La imagen segmentada junto con la temperatura 
![alt text](https://github.com/ljcaviedesb/Imagenes-Termicas/blob/master/Segmentacion%20Termica%20objetos/Cautín/Imagen_Segmentada_fig3.jpg)
