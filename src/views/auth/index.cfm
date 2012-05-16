<cfsilent>
	
	<cfset user = ""/>
	<cfif structKeyExists(session, "user")>
		<cfset user = session.user/>
	</cfif>
	
	<cfset result = event.getValue("result", "")/>

</cfsilent>
<cfoutput>
	<cfif isStruct(result) and result.status eq "failure">
		<p class="error">#result.message#</p>
	<cfelse>
		<p>Please enter your username and password.</p>
	</cfif>
	<form id="loginForm" action="/Auth/processLogin" method="POST">
		<p>
			<label>Username:</label>
			<input type="text" id="username" name="username"/>
		</p>
		<p>
			<label>Password:</label>
			<input type="password" id="password" name="password"/>
		</p>
		<p>
			<input type="submit" id="loginButton" value="Login"/>
		</p>
	</form>
</cfoutput>