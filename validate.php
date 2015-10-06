<?php
 
	// grab recaptcha library
	require_once "recaptchalib.php";
	 
	// your secret key
	$secret = "6LepjgwTAAAAACzAV0hXmzjDniHydMIrOLw4S4a8";
	 
	// empty response
	$response = null;
	 
	// check secret key
	$reCaptcha = new ReCaptcha($secret);

	// if submitted check response
	if ($_POST["g-recaptcha-response"]) {
	    $response = $reCaptcha->verifyResponse(
	        $_SERVER["REMOTE_ADDR"],
	        $_POST["g-recaptcha-response"]
	    );
	}

	if ($response != null && $response->success) {
		//Curl version
        $ch = curl_init();
        curl_setopt( $ch, CURLOPT_URL, "http://www.louisianime.com/formtools/process.php");
        curl_setopt( $ch, CURLOPT_POST, 1);
        curl_setopt( $ch, CURLOPT_POSTFIELDS, $_POST);
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true);

        $response = curl_exec($ch);        
        curl_close($ch);
        header( 'Location: http://www.louisianime.com/thanks/' ) ;
	} else { header( 'Location: http://www.louisianime.com/form-error' ) ; }
?>