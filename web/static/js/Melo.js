import React, { PropTypes } from 'react'
import Navigation from 'components/Navigation'

const Melo = ({children = undefined}) => (
  <main>
    <Navigation />

    {children}
  </main>
)

Melo.propTypes = {
  children: PropTypes.object
}

export default Melo
