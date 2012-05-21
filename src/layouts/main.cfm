<cfsilent>
	<cfset pageTitle = event.getValue("pageTitle", "")/>
	<cfif len(pageTitle)>
		<cfset pageTitle = getSetting("site").title & " : " & pageTitle/>
	<cfelse>
		<cfset pageTitle = getSetting("site").title/>
	</cfif>	
	<cfset release = getSetting("release")/>
	<cfset version = getSetting("version")/>
	
	<cfset user = event.getValue("user", "", true)/>
</cfsilent>
<html>
<head>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=device-width"/>

	<cfoutput>
	<title>#pageTitle#</title>
	<link rel="stylesheet" media="screen" href="/css/style.css?v=#release#"/>
	<link href="http://fonts.googleapis.com/css?family=IM+Fell+DW+Pica+SC" rel="stylesheet" type="text/css">
	<script src="/js/app.js?v=#release#"></script>
	</cfoutput>
</head>
<body>
	<section class="wrapper">
		<section id="account">
			<cfif isObject(user)>
				<cfoutput>
					Hello, #user.getFirstName()# #user.getLastName()#. <a href="/Auth/logout" id="logoutLink" class="">Logout</a>
				</cfoutput>
			<cfelse>
				<cfif not event.getCurrentHandler() eq "Auth">
					<a href="/Auth/index" id="loginLink" class="">Login</a>
				</cfif>
			</cfif>
		</section>

		<cfoutput>
		<header>
			The Automaton
		</header>
		<article>
			#renderView()#
		</article>
		<footer>
			#getSetting("site").title# #getSetting("version")# r#release#
			<cfif structKeyExists(server, "railo")>
				on Railo #server.railo.version#
			<cfelseif structKeyExists(server, "bluedragon")>
				on Open BlueDragon #replace(server.bluedragon.productversion, ",", ".", "all")#
			<cfelseif structKeyExists(server, "coldfusion")>
				on Adobe ColdFusion #replace(server.coldfusion.productversion, ",", ".", "all")#
			</cfif>
			<cfif structKeyExists(request, "connection")>
				at #request.connection.node.name#
				<cfif request.connection.node.address neq "0.0.0.0">
					(#request.connection.node.address#:#request.connection.node.port#)
				</cfif>
			</cfif>
		</footer>
		</cfoutput>
	</section>
</body>
</html>