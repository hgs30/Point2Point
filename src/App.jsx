import './App.css'
import GoogleAuth from "./components/auth/GoogleAuth.jsx";
import {useEffect, useState} from "react";
import {supabase} from "./supabaseClient.js";
import Signout from "./components/auth/Signout.jsx";
import '@mantine/core/styles.css';
import {MantineProvider, Autocomplete} from '@mantine/core';

function App() {
    const [session, setSession] = useState(null)
    const [loading, setLoading] = useState(true)
    const [data, setData] = useState([])

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
        let ignore = false

        async function retrieveData() {
            setLoading(true)
            const {data, error} = await supabase
                .from('airport')
                .select('code')

            if (!ignore) {
                if (error) {
                    console.warn(error)
                } else if (data) {
                    console.log(data)
                    setData(data.map(value => value.code))
                }
            }
            setLoading(false)
        }

        retrieveData()

        return () => {
            ignore = true
        }
    }, [session])

    return (
        <MantineProvider>
            <div className="container">
                <h1>Welcome to Point2Point</h1>
                {null == session && <GoogleAuth/>}
                {null != session && <Signout/>}
                {!loading && <Autocomplete label="Your favorite library"
                                           placeholder="Pick value or enter anything" data={data}/>}
            </div>
        </MantineProvider>
    )
}

export default App
