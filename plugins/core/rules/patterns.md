# Buscar el patrón antes de reparar — regla global

Regla siempre activa. Gobierna **la unidad de trabajo**: qué es lo que se arregla cuando algo
falla. Las demás reglas dicen cómo hacer bien una cosa; esta dice si esa cosa es la cosa.

## El principio

**Un defecto casi nunca es la unidad del problema. La unidad es el mecanismo que lo produjo.**

Cada instancia se presenta como completa y suficiente en sí misma, y ese es el problema: reparar
la instancia se siente como terminar. Un comentario en un fichero parece un problema de
comentarios. Solo cuando se pone al lado de un grep ciego al CSS y de otro que escanea el
directorio equivocado aparece lo que de verdad pasa: *nuestros gates son greps con agujeros
silenciosos y nadie los prueba*. Ese enunciado no es visible desde ninguna de las tres instancias
por separado.

## El disparador, que es lo operativo

"Piensa en la enfermedad y no en el síntoma" es un buen consejo y por sí solo no se aplica nunca,
porque no tiene momento. Este sí lo tiene:

> **Antes de reparar, busca la segunda instancia.**
> Una es un incidente. Dos es un mecanismo, y entonces la unidad de trabajo es el mecanismo.

Buscar la segunda instancia es barato —un grep, mirar el fichero hermano, preguntarse dónde más
vive esta forma— y es lo que se salta por defecto, porque la primera ya está arreglada y arreglar
se siente como avanzar.

## Las tres preguntas

Cuando aparezca un defecto, antes de tocar nada:

1. **¿Dónde más vive esta forma?** No el mismo error: la misma *forma* de error. Un punto sin
   escapar en un grep y una regex que solo entiende una de las dos sintaxis del repo son el mismo
   error de forma —"la comprobación no cubre lo que dice cubrir"— escrito en sitios distintos.
2. **¿Qué tendría que ser cierto para que esto no hubiera pasado?** Y de eso: ¿existe? ¿se carga?
   Una regla que existe pero no se carga en el momento de actuar no existe.
3. **¿Es esto la enésima tirita sobre lo mismo?** Si la respuesta anterior a este problema fue
   crear un documento, un fichero o una capa, y el problema sigue, la capa nueva no es la cura:
   es el síntoma de que la anterior no se aplicaba.

## Cómo NO se ve una cura

Señales de que se está tratando el síntoma con cara de estar curando:

- **Un documento nuevo.** Escribir un documento es la acción más barata disponible y la que menos
  cambia el comportamiento. Si el problema es que nadie lee el documento que ya hay, el sexto
  documento tampoco se lee.
- **Mover algo de sitio.** Reorganizar dónde vive una regla no la hace cumplirse.
- **Arreglar las N instancias encontradas** sin preguntarse qué las produjo ni qué impedirá la
  N+1.
- **Añadir una comprobación sin probarla.** Un gate es código. Un gate sin fixture que lo verifique
  rota igual que un documento sin lector, y encima miente en verde.

## Cómo sí

Una regla se cumple si y solo si **está presente en el momento de actuar**. De ahí se deriva todo
lo demás, y hay exactamente tres vías:

| vía | cuándo está presente | para qué sirve |
|---|---|---|
| inline en el `CLAUDE.md` del repo | siempre, se carga sola | lo que hay que tener en la cabeza al escribir |
| un hook | siempre, se ejecuta solo | verdad de tierra que el modelo no puede observar |
| un gate con fixtures | al confirmar | lo mecánicamente comprobable |

Un fichero de reglas sin ninguna de las tres es prosa. Al escribir una regla nueva, la pregunta
no es dónde ponerla: es **cuál de las tres vías la va a cargar**. Si no hay respuesta, no se ha
escrito una regla.

## La escalera de enforcement (v0.15.0)

Estar cargada no basta. La semana del 08-08 lo midió: `npx vitest` se tecleó con la prohibición
leída veinte minutos antes; una mejora se afirmó con la regla normativa citada ese mismo día; el
registro llano falló tres días seguidos con su cláusula activa. El fallo no era el loader — era
el **disparador**: la prosa pide reconocer el momento de aplicarse, y ese reconocimiento es justo
lo que falla bajo carga o cuando el resultado conviene (razonamiento motivado, no olvido).

> **Una regla violada dos veces estando cargada no se re-escribe como más prosa: sube de vía.**

La subida tiene dos formas, y las dos sustituyen reconocimiento por mecánica:

- **Sustituto concreto:** no "nunca X" sino "para <esta intención>, teclea Y". «Nunca `npx
  vitest`» falló tres veces; «para correr un fichero: `npm test -- <fichero>`» funcionó a la
  primera.
- **Gate determinista** en la frontera de la acción (hook, pre-push, check de arranque). El gate
  de versión de Node cazó una violación real en su primera hora de vida.

Corolarios: una tercera anotación descriptiva de la misma violación no aporta diagnóstico — a la
segunda, la entrada del friction-log propone el sustituto o el gate, y la retro lo encola como
build. Y todo build encolado **se revalida contra el árbol al abordarse**: un TODO redactado
sobre evidencia de hace días puede estar ya curado, o quedarse corto (visto 08-11: de tres TODOs
encolados, uno estaba casi curado y otro tenía cifras cinco veces cortas).

## Por qué esta regla existe

2026-08-06, MintStash. Andrés: *"si no te hablo de enfermedad vs síntoma, la gran mayoría del
tiempo lo pasas por alto"*. Es exacto, y tiene la misma forma que todo lo que habíamos
diagnosticado esa tarde: la capacidad existe, y nada la invoca en el momento en que hace falta.
El mecanismo de carga era él, diciéndolo en voz alta. Esta regla es el intento de que deje de
serlo.
