
# Asynclock
 
Reloj y Termómetro asíncrono, alimentado por data del API de darksky.net (forecast.io)

¿Como funciona?
---------

Al entrar a la pantalla principal. se muestra la hora y temperatura de 6 locaciones 
en tiempo real (Cada 10 segundos) 

Las ciudades son:
* Santiago (Chile) 
* Zurich (Suiza)
* Auckland (New Zealand) 
* Sydney (Australia) 
* London (England)
* Georgia (USA) 

Por defecto la aplicación realiza la primera consulta, luego guarda en cache su respuesta, y la utiliza, 
debido a que el API de forecast solo te permite realizar 1000 llamadas al dia.

Por esta razón, para probar la funcionalidad del API para todas las llamadas, debe agregarse la siguiente 
variable de entorno al proyecto en Heroku:

`API_REQUESTS_ENABLED=true` 

Luego de hacer esto, y reiniciar la app en Heroku, la aplicación pasa a consultar el API en cada llamada, 
y por ende a gastarse todas las consultas del día en aproximadamente 30 minutos. 

-----------------------------

Aplicación de reclutamiento de AcidLabs.

Desarrollada por Jorge Fuentes, 2019