import './App.css'
import GoogleAuth from "./components/auth/GoogleAuth.jsx";
import {useEffect, useState} from "react";
import {supabase} from "./supabaseClient.js";
import Signout from "./components/auth/Signout.jsx";


function App() {
    const [session, setSession] = useState(null)
    const [user, setUser] = useState(null)

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

    useEffect(() => {
        supabase.auth.getUser().then(({data: {user}}) => setUser(user))
    }, [])

    return (
        <div className="container">
            <h1>Welcome to Point2Point</h1>
            {null == session && <GoogleAuth/>}
            {null != session && <Signout/>}
        </div>
    )
}

export default App
