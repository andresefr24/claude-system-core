# Verificar contra la fuente — regla global

Regla siempre activa. Extiende el "nunca de memoria" del vault a **toda afirmación de hecho o
diagnóstico** que tenga una fuente de verdad accesible: la base de datos, los logs, el código, el
estado vivo de un servicio, un normativo del vault, un fichero en disco.

## El principio

**No afirmes un diagnóstico o un dato que no hayas verificado contra su fuente accesible.** Si la
fuente está a una query, un grep, un `git log` o un Read de distancia, se consulta *antes* de
afirmar — no después de que Andrés corrija.

Una diagnosis segura-pero-falsa es peor que "déjame comprobar": consume la corrección de Andrés
para desbloquearse y erosiona la confianza en todo lo demás que afirmes. La comodidad de una
explicación que "cierra el caso" es precisamente la señal de alarma.

## Qué cuenta como fuente accesible

- **Datos de producto** (precios, cobertura, conteos, estados): la BD / snapshots, no la memoria.
- **Reglas de dominio vigentes** (formatos, bans, políticas): la fuente vigente, no lo recordado.
- **Comportamiento del código**: el código y los logs, no el modelo mental de cómo "debería" ser.
- **Estado de deploy / infra**: el estado vivo (`git log origin/main..main`, el panel del servicio),
  no el supuesto de que lo local = lo desplegado.
- **Normativos del proyecto**: el fichero del vault (esto ya lo cubría "nunca de memoria").

## La disciplina

1. **Toda explicación de un síntoma es una HIPÓTESIS** hasta confirmarla contra la fuente. Nómbrala
   como hipótesis si aún no la verificaste; no la presentes como causa.
2. **Al filtrar o contar por un campo, comprueba nulls/cobertura primero** — un campo con nulls
   omite filas en silencio y falsea el resultado.
3. **Al reportar una métrica, declara contra qué universo se mide** (tabla de mercado vs contenido
   de la app, etc.); una cobertura sin universo nombrado engaña.
4. **Una comprobación parcial no es una comprobación.** Al verificar, nombra **qué superficie
   miraste** y si podría haber otra: un fichero no es el repo, una tabla no es el esquema, la BD no
   es el código, un grep no es una lectura. Dos casos obligatorios:
   - **Antes de borrar o renombrar algo con id**, la superficie incluye un `grep` del repo por ese
     id. Un renombrado lo caza el compilador; un id borrado no lo caza nadie, porque es una cadena.
   - **Antes de describir para qué sirve un fichero**, ábrelo. Un nombre no es su contenido.
5. **El instrumento también se verifica.** El punto 4 pregunta *cuánto* miraste; este pregunta si
   tu instrumento **puede contestar la pregunta que le haces**. Antes de afirmar un número o un
   diagnóstico, di qué NO habría podido detectar tu instrumento — si la respuesta invalida la
   afirmación, no la hagas. Tres formas concretas:
   - **Una pasada no es una medida.** Todo lo que varía (latencias, tiempos, planes de query) se
     mide más de una vez; una sola muestra de algo ruidoso no distingue regresión de ruido.
   - **Verde solo dice lo que el check mira.** Un check que pasa certifica su propio alcance, no
     "que está bien"; un parser que no resuelve nombres no valida que la query funcione.
   - **Si lo medido y lo observado se contradicen, duda del instrumento primero.** Un navegador
     que enseña vacío mientras la API devuelve datos es un navegador degradado, no una caída.

## Procedimiento asociado (helper opcional, por proyecto)

Para el caso reconocido "anomalía con datos concretos que perseguir", un proyecto **puede** proveer
un skill-procedimiento que prescriba su flujo de verificación (p. ej., en un proyecto con base de
datos: consultar la fuente por ground truth → localizar el path divergente en el código → causa raíz
→ fix → re-verify). Ese helper vive en el vault/skills **del proyecto**, no aquí. Esta regla es la
base genérica y portable que aplica **siempre**, en cualquier proyecto y también cuando el modelo no
reconoce que está ante una anomalía — que es justo cuando la explicación de memoria se cuela. El
skill del proyecto acelera el caso reconocido; la regla cubre el resto.

## Razón

**Ampliada el 2026-08-07 (v0.14.0)** con el punto 5, tras CINCO fallos en una sesión (06-08) que los
puntos 1–4 no cazaron porque todos sus ejemplos eran de cobertura (qué subconjunto miraste) y ninguno
de capacidad (si el instrumento puede contestar): dos checks de SQL en falso verde, un navegador
degradado leído como caída de producción, un EXPLAIN suelto leído como regresión, una llamada en frío
reportada como presupuesto consumido. La regla funciona por sus ejemplos concretos; cada forma nueva
de fallo necesita el suyo. Detalle en el friction-log.

**Ampliada el 2026-08-05** con el punto 4, tras tres fallos del mismo tipo en una sola sesión con la regla ya activa: describir un fichero por su nombre sin abrirlo, borrar una fila de la BD sin grepear el repo por su id, y concluir que no existían tokens tras mirar un solo fichero. Los tres tenían la fuente a un Read o un grep de distancia, y los tres los cazó Andrés preguntando, no un gate. Detalle en el friction-log.

Retro 2026-08-01 + friction-log 16 y 17-jul-2026: dos incidentes de afirmar datos y diagnósticos de
memoria teniendo la fuente accesible (los datos en la BD, el estado real en el código) — uno cifró
valores de memoria, otro dio una narrativa plausible que no aguantó y ocultó una causa más grave.
Andrés decidió atacar la enfermedad en su tier base —una regla siempre-activa y portable— en vez de
confiar solo en un skill *triggered*, que no dispara precisamente cuando el modelo no reconoce que
debe verificar. Los helpers concretos por proyecto son instancias de esta regla, no dependencias de ella.
