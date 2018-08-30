$url = "https://jira.atlassian.com/rest/api/2/search?jql=project%20%3D%20JRASERVER%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20priority%20DESC%2C%20updated%20DESC"
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

# $pass = Get-Credential -UserName $user -Message "input password"
# $pair = "${user}:${pass}"
# $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

  try {
    Invoke-RestMethod $url -Headers $headers
        -Body (ConvertTo-Json $data) 
        -ContentType "application/json" 
        -Headers $DefaultHttpHeaders 
        -Method Post
    }
    catch {
        $streamReader = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream())
        $ErrResp = $streamReader.ReadToEnd() | ConvertFrom-Json
        $streamReader.Close()
    }
        $ErrResp