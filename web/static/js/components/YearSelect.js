import React from 'react'

const YearSelect = ({onChange, selected}) => (
  <select onChange={e => onChange(e.target.value)} defaultValue={parseInt(selected, 10)}>
    {[2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009, 2008, 2007, 2006, 2005,
      2004, 2003, 2002, 2001, 2000, 1999, 1998, 1997, 1996].map(y =>
      <option key={y} value={`${y}`}>{y}</option>
    )}
  </select>
)

export default YearSelect
