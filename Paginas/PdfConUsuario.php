<?php
	session_start();
	if (!isset($_SESSION['idUsuario']) || !isset($_POST['idCita'])) {
		header("Location: ../");
	}
	require_once '../Librerias/dompdf/autoload.inc.php';
	include("../Librerias/Conexion.php");
	use Dompdf\Dompdf;

	$idCita = $_POST['idCita'];

	$consulta1 = "SELECT m.nombre, e.nombre as nombreEsp, m.consultorio, m.telefono, c.fecha, 
						e.costoCita
					FROM medicos m, citas c, especialidades e
					WHERE c.id = $idCita AND m.id = c.idMedico AND e.id = m.especialidad";
	$resultado = $mysqli -> query($consulta1);
	$filas = $resultado -> fetch_assoc();

	$consulta = "SELECT  u.nombre, p.porcentajeDesc 
					FROM citas c, usuarios u, planes p
					WHERE c.idUsuario = u.id AND p.id = u.plan AND c.id = $idCita";
	$resultado = $mysqli -> query($consulta);
	$filas2 = $resultado -> fetch_assoc();

	$desc = $filas['costoCita'] * $filas2['porcentajeDesc'];
	$total = $filas['costoCita'] - $desc;

	$html = "
	<html>
	<head>
		<title></title>
		<style type='text/css'>
			body {font-family: sans-serif;}
			h1 {
				color: white;
				background-color: dodgerblue;
				text-align: center;
			}
			#Folio {
				width:100%;
				display: block;
				float: right;
				overflow: hidden;
				text-align: right;
			}
			.tablaCitas{
			  /*border-collapse: collapse;*/
			  width: 100%;
			  margin-top: 35px;
			  margin-bottom: 20px;
			}
			.tablaCitas tr:nth-child(even){background-color: #f2f2f2;}
			.tablaCitas tr:hover {background-color: #ddd;}
			.tablaCitas td, #tablaCitas th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}
			.tablaCitas th {
			  padding-top: 12px;
			  padding-bottom: 12px;
			  text-align: left;
			  background-color: dodgerblue;
			  color: white;
			}
			#cont2 {
				width: 40%;
				margin-left: auto;
			}

		</style>
	</head>

	<body>
		<h1>Hospital Arcangeles</h1>

		<p>
		Av. Paseo de la Victoria 4370, Partido Iglesias, 32618.<br>
		Cd Juarez, Chihuahua, Mexico.<br>
		52(656)222 5825.<br> 
		52(656)131 2585.<br>
		</p>

		<div id='Folio'>
			<p><b>Numero de folio:</b> $idCita </p>
			<p><b>Fecha:</b> $filas[fecha] </p>
		</div>

		<div id='contTabla'>
			<h2> $filas2[nombre] </h2>
			<table class='tablaCitas'>
				<tr>
					<th>Nombre del medico</th>>
					<th>Especialidad</th>
					<th>Consultorio</th>
					<th>Telefono</th>
					<th>Fecha de cita</th>
				</tr>
				<tr>
					<td> $filas[nombre] </td>
					<td> $filas[nombreEsp] </td>
					<td> $filas[consultorio] </td>
					<td> $filas[telefono] </td>
					<td> $filas[fecha] </td>
				</tr>
			</table>
		</div>
		
		<div id='cont2'>
			<table class='tablaCitas' id='pago'>
				<tr>
					<th>Subtotal</th>
					<td> $ $filas[costoCita] </td>
				</tr>
				<tr>
					<th>Descuento</th>
					<td> $ $desc.00 </td>
				</tr>
				<tr>
					<th>Total</th>
					<td> $ $total.00 </td>
				</tr>
				<tr>
					<th>Pagado</th>
					<td> $ $total.00 </td>
				</tr>
				<tr>
					<th>Adeudo</th>
					<td> $ 0.00 </td>
				</tr>
			</table>
		</div>

		<div>
			<br><br><br>
			<center>
			<img src='../Imagenes/FooterPdf.png'>
			</center>
		</div>
	</body>
	</html>
	";

	/*$html = file_get_contents("http://localhost/HospitalArcangeles/Paginas/CitasUsuarios.php");*/
	$mipdf = new DOMPDF();


	$mipdf ->set_paper("A4", "portrait");
	$mipdf ->load_html(utf8_decode($html));
	$mipdf ->render();
	$mipdf ->stream('Recibo.pdf');
?>
