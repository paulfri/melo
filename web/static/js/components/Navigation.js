import React from 'react'
import { Link } from 'react-router'

const Navigation = () => (
  <nav className='navigation'>
    <section className='container'>
      <Link to={`/`}>Melo</Link>

      <ul className='float-right'>
        <li><Link to={`/standings`}>Standings</Link></li>
        <li><Link to={`/elo`}>Elo</Link></li>
      </ul>
    </section>
  </nav>
)

export default Navigation
