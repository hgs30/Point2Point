import {supabase} from "../../supabaseClient.js";
import {useEffect, useState} from "react";

function onSignInClick() {
    supabase.auth.signInWithOAuth({
        provider: 'google',
        options: {
            redirectTo: `http://localhost:5173/`,
        },
    })
}

function GoogleSignIn() {
    const [session, setSession] = useState(null)

    useEffect(() => {
        supabase.auth.getSession().then(({data: {session}}) => {
            setSession(session)
        })

        const {
            data: {subscription},
        } = supabase.auth.onAuthStateChange((_event, session) => {
            setSession(session)
        })

        return () => subscription.unsubscribe()
    }, [])
    return (
        <div className="container">
            {null != session ? <>
                <button onClick={() => setSession(null)}>Click here to sign out</button>
            </> : <button onClick={onSignInClick}>Click here to sign in with Google</button>}
        </div>
    )
}

export default GoogleSignIn
