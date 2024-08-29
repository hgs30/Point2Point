import './App.css'
import GoogleAuth from "./components/auth/GoogleAuth.jsx";
import {useEffect, useState} from "react";
import {supabase} from "./supabaseClient.js";
import Signout from "./components/auth/Signout.jsx";
import '@mantine/core/styles.css';
import {MantineProvider} from '@mantine/core';
import AirportAutocomplete from "./components/AirportAutocomplete.jsx";
import {
    QueryClient,
    QueryClientProvider
} from '@tanstack/react-query'

const queryClient = new QueryClient({
    defaultOptions: {
        queries: {
            retry: 0,
            refetchOnMount: false,
            refetchOnWindowFocus: false
        }
    }
})

function App() {
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
        <MantineProvider>
            <QueryClientProvider client={queryClient}>
                <div className="container">
                    <h1>Welcome to Point2Point</h1>
                    {null == session && <GoogleAuth/>}
                    {null != session && <Signout/>}
                    <AirportAutocomplete/>
                </div>
            </QueryClientProvider>
        </MantineProvider>
    )
}

export default App
