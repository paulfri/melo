import React from 'react'
import classNames from 'classnames'

export default class Button extends React.Component {
  static propTypes = {
    active: React.PropTypes.bool,
    size: React.PropTypes.oneOf([
      'small',
      'large'
    ])
  }

  render () {
    const classes = classNames('button', {
      'button-small': this.props.size === 'small',
      'button-large': this.props.size === 'large',
      'button-outline': !this.props.active
    })

    return (
      <div className={classes}>
        {this.props.children}
      </div>
    )
  }
}
