// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .



var api = 'http://localhost:8000';
var fw = new FabriqWallet(api);
$(document).ready(function() {

	// Smooth Scroll
	//////////////////////////
	$('a[href*=#]:not([href=#])').click(function() {
	  if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') 
	      || location.hostname == this.hostname) {

	      var target = $(this.hash);
	      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
	         if (target.length) {
	           $('html,body').animate({
	               scrollTop: target.offset().top + 5
	          }, 750);
	          return false;
	      }
	  }
	});

	/*
	 * Pending Transaction Alerts
	 */
	function loadPendingTrasnactions() {
	}

	function checkPendingTransactions() {
	}

	/*
	 * User Registration Methods
	 */
	// onkeyup username availability
	var lookupInterval = 1000;
	var looking = false;
	function delayedUserLookup() {
		looking = false;
		var name = document.getElementById('name').value;
		if (name.length > 0)
			fw.nameAvailable(name, function(err, avail) {
				if (err || !avail) $('.result').html("Name unavailable");
				else $('.result').html("");
			});
		else $('.result').html("");
	}
	$('#name').keyup(function() {
		if (!looking) {
			setTimeout(delayedUserLookup, lookupInterval);
			looking = true;
		}
	});

	// Registration validation
	var checkRegInterval = 5000; 	// check for registration every 5 seconds
	var checkRegId;

	var txHash = localStorage.getItem('registering');
	if (txHash && txHash.length) {
		$('#signup').prop('disabled', true);
		checkRegId = setInterval(checkRegistration, checkRegInterval);
	}

	$('#register').click(function() {
		var pw1 = $('#password1').val();
		var pw2 = $('#password2').val();
		var username = $('#name').val();
		var email = $('#email').val();
		if (pw1 !== pw2) $('#result').html("Passwords do not match");
		else {
			$('#result').html("");
			fw.create(username, pw1, email, function(err, data) {
				if (err || !data || !data.txhash) $("#result").html(err);
				else {
					disableSignup();
					localStorage.setItem('registering', data.txhash);
					checkRegId = setInterval(checkRegistration, checkRegInterval);
				}
			});
		}
	});

	function checkRegistration() {
		txHash = localStorage.getItem('registering');
		if (!txHash || !txHash.length) clearInterval(checkRegId);
		else
			fw.validate(function(err, id) {
				// Throw err after X attempts
				if (err) {
					enableSignup();
					$('.result').html("Registration timed out");
					localStorage.setItem('registering', '');
				}
				else if (id) {
					$.post('/sessions', {id: id}, function() {
						clearInterval(checkRegId);
						enableSignup();
						localStorage.setItem('registering', '');
						window.location.href = '/main/index';
					});
				}
			});
	}

	function disableSignup() {
		$('.result').html("Registering username");
		$('div.signup').css("pointer-events", 'none');
		$('.signup input').css('opacity', 0.5);
		$('.signup a').css('opacity', 0.5);
	}
	function enableSignup() {
		$('.result').html("");
		$('div.signup').css("pointer-events", 'auto');
		$('.signup input').css('opacity', 1);
		$('.signup a').css('opacity', 1);
	}

	// User Login
	$("#signin").click(function() {
		var username = $("#signin_name").val();
		var pw = $("#signin_password").val();
		$("#signin").prop('disabled', true);
		fw.load(username, pw, function(err, userid) {
			$("#signin").prop('disabled', false);
			if (err) {
				$('.result').html(err);
			} else if (!userid) $('.result').html("User not found");
			else {
				$.post('/sessions', {id: userid}, function(data) {
					window.location.href = '/main/index';
				});
			}
		});
	});

	// User Logout
	$('#logout').click(function() {
		fw.logout();
	});

});

