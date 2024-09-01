import {Autocomplete, Button, Table} from '@mantine/core';
import {DateInput} from '@mantine/dates';
import dayjs from "dayjs";
import {useState} from "react";
import useAirports from "../hooks/useAirports.js";
import useFlights from "../hooks/useFlights.js";

function FlightSearch() {
    const [search, setSearch] = useState();
    const [from, setFrom] = useState();
    const [to, setTo] = useState();
    const [when, setWhen] = useState();

    const airportsQuery = useAirports();
    const flightQuery = useFlights(search)

    function onSearch() {
        const fromAirport = airportsQuery.data?.find(airport => airport.label === from)?.value;
        const toAirport = airportsQuery.data?.find(airport => airport.label === to)?.value;
        setSearch({
            "from": fromAirport,
            "to": toAirport,
            "when": dayjs(when).format('YYYY-MM-DD')
        })
    }

    const rows = flightQuery.data?.map((flight) => (
        <Table.Tr key={flight.id}>
            <Table.Td>{flight.points}</Table.Td>
            <Table.Td>{`${flight.taxes} ${flight.currency.code}`}</Table.Td>
            <Table.Td>{flight.date}</Table.Td>
        </Table.Tr>
    ));

    return (<>
        <Autocomplete
            label={"From"}
            placeholder={"From"}
            data={airportsQuery.data}
            value={from}
            onChange={setFrom}
        />
        <Autocomplete
            label={"To"}
            placeholder={"To"}
            data={airportsQuery.data}
            value={to}
            onChange={setTo}
        />
        <DateInput label={"When"} placeholder={"When"} value={when} onChange={setWhen}/>
        <Button variant="filled" color="green" size="md" onClick={onSearch}>Search</Button>
        <Table stickyHeader={true}>
            <Table.Thead>
                <Table.Tr>
                    <Table.Th>Points</Table.Th>
                    <Table.Th>Taxes</Table.Th>
                    <Table.Th>Date</Table.Th>
                </Table.Tr>
            </Table.Thead>
            <Table.Tbody>{rows}</Table.Tbody>
        </Table>
    </>)
}

export default FlightSearch
