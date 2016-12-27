import React from 'react'
import { Link } from 'react-router'

const NoMatch = () => (
  <section className='container'>
    Not found. <Link to='/'>Return home.</Link>
  </section>
)

export default NoMatch
