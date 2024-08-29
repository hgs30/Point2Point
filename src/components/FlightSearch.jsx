import {Autocomplete, Button} from '@mantine/core';
import {DateInput} from '@mantine/dates';
import dayjs from "dayjs";
import {useState} from "react";
import useAirports from "../hooks/useAirports.js";
import useFlights from "../hooks/useFlights.js";

function FlightSearch() {
    const {data} = useAirports();
    const [search, setSearch] = useState();
    const [from, setFrom] = useState();
    const [to, setTo] = useState();
    const [when, setWhen] = useState();
    useFlights(search)

    function onSearch() {
        const fromAirport = data?.find(airport => airport.label === from)?.value;
        const toAirport = data?.find(airport => airport.label === to)?.value;
        setSearch({
            "from": fromAirport,
            "to": toAirport,
            "when": dayjs(when).format('YYYY-MM-DD')
        })
    }

    return (<>
        <Autocomplete
            label={"From"}
            placeholder={"From"}
            data={data}
            value={from}
            onOptionSubmit={(selected) => {
                setFrom(selected.value)
            }}
        />
        <Autocomplete
            label={"To"}
            placeholder={"To"}
            data={data}
            value={to}
            onOptionSubmit={(selected) => setTo(selected.value)}
        />
        <DateInput label={"When"} placeholder={"When"} value={when} onChange={setWhen}/>
        <Button variant="filled" color="green" size="md" onClick={onSearch}>Search</Button>
    </>)
}

export default FlightSearch
