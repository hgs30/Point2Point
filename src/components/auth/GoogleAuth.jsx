import {supabase} from "../../supabaseClient.js";

function onSignInClick() {
    supabase.auth.signInWithOAuth({
        provider: 'google',
        options: {
            redirectTo: `http://localhost:5173/`,
        },
    })
}

function GoogleAuth() {
    return <button onClick={onSignInClick}>Click here to sign in with Google</button>
}

export default GoogleAuth
