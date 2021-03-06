import React, { PropTypes } from 'react'

const YearSelect = ({onChange, selected}) => (
  <select onChange={e => onChange(e.target.value)} defaultValue={selected}>
    {[2017, 2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009, 2008, 2007, 2006,
      2005, 2004, 2003, 2002, 2001, 2000, 1999, 1998, 1997, 1996].map(y =>
        <option key={y} value={`${y}`}>{y}</option>
    )}
  </select>
)

YearSelect.propTypes = {
  onChange: PropTypes.func.isRequired,
  selected: PropTypes.string.isRequired
}

export default YearSelect
