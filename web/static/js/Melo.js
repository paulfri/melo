import React from 'react'
import Navigation from 'components/Navigation'

const Melo = ({children = undefined}) => (
  <main>
    <Navigation />

    {children}
  </main>
)

export default Melo
