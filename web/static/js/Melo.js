import React, { PropType } from 'react'
import Navigation from 'components/Navigation'

const Melo = ({children = undefined}) => (
  <main>
    <Navigation />

    {children}
  </main>
)

Melo.propTypes = {
  children: PropType.array
}

export default Melo
