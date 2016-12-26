import React from 'react'
import NavLink from 'components/NavLink'

const Navigation = () => (
  <nav className='navigation'>
    <section className='container'>
      <NavLink to='/'>Melo</NavLink>

      <ul className='float-right'>
        <li><NavLink to='/standings'>Standings</NavLink></li>
        <li><NavLink to='/elo'>Elo</NavLink></li>
      </ul>
    </section>
  </nav>
)

export default Navigation
