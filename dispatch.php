<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Police Emergency Service System</title>
<link rel="stylesheet" type="text/css" href="CSS/body_style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
</head>

<body>
	
	<?php 
	//Validate if request comes from logcall.php or post back
	if (!isset($_POST["btnProcessCall"]) && !isset($_POST["btnDispatch"]))
		header("Location: logcall.php");
	?>
	
	<?php 
	// connect to a database
	require_once 'db.php';
	//create connection
	$conn = new mysqli (DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);
	//check connection
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	}
	//retrieve from patrolcar table those patrol cars that are 2:Patrol or 3:Free
	$sql = "SELECT patrolcar_id, patrolcar_status_desc FROM patrolcar JOIN patrolcar_status ON patrolcar.patrolcar_status_id=patrolcar_status.patrolcar_status_id WHERE patrolcar.patrolcar_status_id='2' OR patrolcar.patrolcar_status_id='3'";
	
	$result = $conn->query($sql);
	
	if ($result->num_rows > 0) {
		while ($row = $result->fetch_assoc()) {
			$patrolcarArray[$row['patrolcar_id']] = $row['patrolcar_status_desc'];
		}
	}
	
	$conn->close();
	?>
	
<?php 
	// if postback via clicking dispatch button
	if (isset($_POST["btnDispatch"]))
	{
		require_once 'db.php';
		
		//create connection
		$conn = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);
			
		//check connection
		if ($conn->connect_error) {
			die("Connection failed: " . $conn->connect_error);
	}

	$patrolcarDispatched = $_POST["chkPatrolcar"]; //array of patrolcar being dispatched from post back
	$numofPatrolcarDispatched = count($patrolcarDispatched);
	
	if ($numofPatrolcarDispatched > 0) {
		$incidentStatus="2"; //incident status to be set as Dispatched
	} else {
		$incidentStatus="1"; //incident status to be set as Pending
	}
	$sql = "INSERT INTO incident (caller_name, phone_number,incident_type_id, incident_location, incident_desc, incident_status_id) VALUES ('".$_POST['callerName']."','".$_POST['contactNo']."', '".$_POST['incidentType']."', '".$_POST['location']."', '".$_POST['incidentDesc']."', $incidentStatus)";
		if ($conn->query($sql)===FALSE) {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
		
		
	// retrieve incident_id for the newly inserted incident
	$incidentId=mysqli_insert_id($conn);;
		
	// update patrolcar status table and add into dispatch table
	for($i=0; $i < $numofPatrolcarDispatched; $i++)
	{
		// update patrolcar status////////////////////////
		$sql = "UPDATE patrolcar SET patrolcar_status_id='1' WHERE patrolcar_id = '".$patrolcarDispatched[$i]."'";
		
		if ($conn->query($sql)===FALSE) {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
		
		// insert dispatch data //////////////
		$sql = "INSERT INTO dispatch (incident_id, patrolcar_id, time_dispatched) VALUES ($incidentId, '".$patrolcarDispatched[$i]."', NOW())";
		
		if ($conn->query($sql)===FALSE) {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
	}
	
	$conn->close();
	?>
	
	<!--After dispatching, redirect to logcall.php-->
	<script type="text/javascript">window.location="./logcall.php";</script>
	
	<?php
	}
	require_once'nav.php';
	?>
		
<!--display the incident information passed from logcall.php-->
	<form name="form1" method="post" action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?> ">
		
		<table class="ContentStyle">
			<tr>
				<th colspan="2">Incident Detail</th>
			</tr>
			
			<tr>
				<td>Caller's Name :</td>
				<td><?php echo $_POST['callerName'] ?><input type="hidden" name="callerName" id="callerName" value="<?php echo $_POST['callerName']?>"></td>
			</tr>
			<tr>
				<td>Contact No :</td>
				<td><?php echo $_POST['contactNo'] ?><input type="hidden" name="contactNo" id="contactNo" value="<?php echo $_POST['contactNo']?>"></td>
			</tr>
			<tr>
				<td>Location :</td>
				<td><?php echo $_POST['location'] ?><input type="hidden" name="location" id="location" value="<?php echo $_POST['location']?>"></td>
			</tr>
			<tr>
				<td>Incident Type :</td>
				<td><?php echo $_POST['incidentType'] ?><input type="hidden" name="incidentType" id="incidentType" value="<?php echo $_POST['incidentType']?>"></td>
				
			</tr>
			<tr>
				<td>Description :</td>
				<td><textarea name="incidentDesc" cols="45" rows="5"  readonly id="incidentDesc" ><?php echo $_POST['incidentDesc']?></textarea><input name="incidentDesc" type="hidden" id="incidentDesc" value="<?php echo $_POST['incidentDesc']?>"></td>
			</tr>
			
		</table>
	<br><br>
	<!-- populate table with patrol car data -->
	<table class="ContentStyle">
		<tr>
			<th colspan="3">Dispatch Patrolcar Panel</th>
		</tr>
        
        <tr>
		<?php
            if(empty($patrolcarArray))
                {echo "<p style='font-size: 15px;font-weight: 700;'>" . "None of the car is free." . "</p>";}
            else
            {
			foreach($patrolcarArray as $key=>$value){
		?>
		
			<td><input type="checkbox" required name="chkPatrolcar[]" 
				value="<?php echo $key?>"></td>
			<td><?php echo $key ?></td>
			<td><?php echo $value ?></td>
            
		</tr>
		<?php	}}	?>
        
		<tr>
			<td><input type="reset" name="btnCancel" id="btnCancel" value="Reset"></td>
			<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="btnDispatch" id="btnDispatch" value="Dispatch"></td>
		</tr>
	</table>
</form>
        <p>Done By Looi Hui Hui, QU2101N for school project.</p>
</body>
</html>