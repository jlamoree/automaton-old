<cfcomponent output="false">

	<cffunction name="init" returntype="UserService" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="getUser" returntype="User" access="public" output="false">
		<cfargument name="userId" type="numeric" required="false" default="0"/>
		<cfargument name="username" type="string" required="false" default=""/>
		
		<cfset var user = "null"/>
		<cfset var query = "null"/>
		
		<cfif not arguments.userId and not len(arguments.username)>
			<cfthrow type="InvalidArgumentException" message="The userId or username must be provided."/>
		</cfif>
		
		<cfif arguments.userId>
			<cfquery name="query">
				SELECT userId, username, firstName, lastName, passwordSalt, passwordHash, email, isActive, createDate, modifyDate
				FROM users
				WHERE userId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.userId#"/>
			</cfquery>
			<cfif not query.recordCount>
				<cfthrow type="UserNotFoundException" message="The user with userId #userId# does not exist.">
			</cfif>
		<cfelse>
			<cfquery name="query">
				SELECT userId, username, firstName, lastName, passwordSalt, passwordHash, email, isActive, createDate, modifyDate
				FROM users
				WHERE username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.username#"/>
			</cfquery>
			<cfif not query.recordCount>
				<cfthrow type="UserNotFoundException" message="The user with username #username# does not exist.">
			</cfif>
		</cfif>

		<cfset user = createObject("component", "model.user.User").init()/>
		<cfset user.setUserId(query.userId)/>
		<cfset user.setUsername(query.username)/>
		<cfset user.setFirstName(query.firstName)/>
		<cfset user.setLastName(query.lastName)/>
		<cfset user.setPasswordSalt(query.passwordSalt)/>
		<cfset user.setPasswordHash(query.passwordHash)/>
		<cfset user.setEmail(query.email)/>
		<cfif val(query.isActive)>
			<cfset user.setIsActive(true)/>
		<cfelse>
			<cfset user.setIsActive(false)/>
		</cfif>
		<cfset user.setCreateDate(query.createDate)/>
		<cfset user.setModifyDate(query.modifyDate)/>
		<cfreturn user/>
	</cffunction>
	
	<cffunction name="saveUser" returntype="void" access="public" output="false">
		<cfargument name="user" type="model.user.User" required="true"/>
		
		<cfset var _user = arguments.user/>
		
		<cfif not isNull(_user.getUserId()) and not _user.getUserId()>
			<cfquery>
				INSERT INTO users (
					username,
					firstName,
					lastName,
					passwordSalt,
					passwordHash,
					email,
					isActive
				) VALUES (
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getUsername()#"/>,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getFirstName()#"/>,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getLastName()#"/>,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getPasswordSalt()#"/>,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getPasswordHash()#"/>,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getEmail()#"/>
				<cfqueryparam cfsqltype="CF_SQL_BIT" value="#iif(_user.getIsActive(), de('1'), de('0'))#"/>
				)
			</cfquery>
		<cfelse>
			<cfquery>
				UPDATE users
				SET username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getUsername()#"/>,
					firstName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getFirstName()#"/>,
					lastName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getLastName()#"/>,
					passwordSalt = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getPasswordSalt()#"/>,
					passwordHash = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getPasswordHash()#"/>,
					email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#_user.getEmail()#"/>,
					isActive = <cfqueryparam cfsqltype="CF_SQL_BIT" value="#iif(_user.getIsActive(), de('1'), de('0'))#"/>
				WHERE userId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#_user.getUserId()#"/>
			</cfquery>
		</cfif>
	</cffunction>
</cfcomponent>