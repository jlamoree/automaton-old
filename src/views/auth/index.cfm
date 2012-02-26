<cfsilent>
	
	
</cfsilent>
<cfif event.valueExists("username")>
	<p>
	You are now logged in.
	</p>
<cfelse>
	<form id="loginForm" action="/Auth/index" method="POST">
		<p>
			<label>Username:</label>
			<input type="text" id="username" name="username"/>
		</p>
		<p>
			<label>Password:</label>
			<input type="password" id="password" name="password"/>
		</p>
		<p>
			<input type="submit" value="Login"/>
		</p>
	</form>
</cfif>