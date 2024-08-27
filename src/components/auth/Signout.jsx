import {supabase} from "../../supabaseClient.js";

function handleSignoutClick()
{
    supabase.auth.signOut()
}

function Signout() {
    return <button onClick={handleSignoutClick}>Signout</button>
}

export default Signout
