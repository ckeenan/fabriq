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


//var api = 'http://localhost:8000';
var api = 'http://52.11.176.202:8000';
var fw = new FabriqWallet(api);
$(document).ready(function() {

	// Smooth Scroll
	/////////////////////////////////////////////////////////////////////////////////////
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


	// Mobile Header Events
	/////////////////////////////////////////////////////////////////////////////////////
	var mobileHeader = $('.admin-mobile');
	var mobileLandingHeader = $('.admin-landing-mobile')
	var header = $("#header");

	$(mobileHeader).on("click", function() {
		$(header).toggleClass("mobile-open");
	});

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
		disableSignup();
	}

	$('#register').click(function() {
		var pw1 = $('#password1').val();
		var pw2 = $('#password2').val();
		var username = $('#name').val();
		var email = $('#email').val();
		if (pw1 !== pw2) $('.result').html("Passwords do not match");
		else {
			$('.result').html("");
			fw.create(username, pw1, email, function(err, data) {
				if (err || !data || !data.txhash) $(".result").html(err);
				else {
					disableSignup();
					localStorage.setItem('registering', data.txhash);
					// Reload pending list
					loadPending();
				}
			});
		}
	});

	function disableSignup() {
		$('div.signup').css("pointer-events", 'none');
		$('.signup input').css('opacity', 0.5);
		$('.signup a').css('opacity', 0.5);
	}

	// User Login
	$("#signin").click(function() {
		var username = $("#signin_name").val();
		var pw = $("#signin_password").val();
		fw.load(username, pw, function(err, userid) {
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

	var regTx = localStorage.getItem('registering');
	if (regTx && regTx.length) disableSignup();
	loadPending();
});

	/*
	 * Pending Transaction Listing
	 */
function loadPending() {
	// Detach the cloned el
	var base = $('#pending #basePending').detach();
	$('#pending').empty().append(base);

	// if pending 
	var txList = fw.txstore.txList;
	var txDict = fw.txstore.txDict;

	// For each pending tx clone the jquery object (for now) and update it's id to the tx id
	for (var i = 0; i < txList.length; i++) {
		var txid = txList[i];
		var tx = txDict[txid];
		var baseEl = $('#basePending').clone();
		baseEl.attr('id', txid);
		baseEl.css('display', 'block');
		baseEl.find('.pending-msg').text(tx.msgDict['pending']);
		baseEl.appendTo('#pending');
	}
	// Set watch interval if needed and not already set
	if (txList && txList.length && !pendingIntervalId)
		pendingIntervalId = setInterval(checkPendingTransactions, pendingInterval);
}

var pendingIntervalId;
var pendingInterval = 5000;

function enableSignup() {
	$('div.signup').css("pointer-events", 'auto');
	$('.signup input').css('opacity', 1);
	$('.signup a').css('opacity', 1);
}

function checkPendingTransactions() {
	var regTxHash = localStorage.getItem('registering');
	function clearRegister(el) {
		if (el.id == regTxHash) {
			localStorage.setItem('registering', '');

			// TODO remove validation attempts. Wait for the txhash logs, then see if it has an ID or not...
			fw.validate(function(err, id) {
				// Throw err after X attempts
				if (err) {
					enableSignup();
					// TODO Redirect users to sign in form here (just in case)
					$('.result').html("Registration timed out");
				}
				else if (id) {
					// Post the user id to create a session
					$.post('/sessions', {id: id}, function() {
						window.location.href = '/main/index';
					});
				} else enableSignup();
			});
		}
	}

	fw.txstore.checkAll(function(err, results) {
		results.forEach(function(el) {
			clearRegister(el);
			var txEl = $('#' + el.id);
			txEl.find('span.three-quarters-loader').css('display', 'none');
			if (el.result == 'success')
				txEl.find('span.glyphicon-ok').css('display', 'inline');
			else if (el.result == 'fail')
				txEl.find('span.glyphicon-remove').css('display', 'inline');
			else if (el.result == 'timeout')
				txEl.find('span.glyphicon-time').css('display', 'inline');
			txEl.find('.pending-msg').text(el.msg);
		});
		var txList = fw.txstore.txList;
		if (!txList || !txList.length) {
			clearInterval(pendingIntervalId);
			pendingIntervalId = null;
		}
	});
}

function beam(user, amount) {
	fw.beam(user, amount, function(err, data) {
		loadPending();
	});
}

function link(user) {
	fw.link(user, function(data) {
		loadPending();
	});
}
