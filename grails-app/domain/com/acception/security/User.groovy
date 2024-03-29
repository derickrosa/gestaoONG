package com.acception.security


class User implements Serializable {

    private static final long serialVersionUID = 1

    transient springSecurityService
    transient BCryptPasswordEncoderService

    String username
    String nome
    String password
    String email

    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    User(String username, String password) {
        this.username = username
        this.password = password
    }

    @Override
    int hashCode() {
        username?.hashCode() ?: 0
    }

    @Override
    boolean equals(other) {
        is(other) || (other instanceof User && other.username == username)
    }

    @Override
    String toString() {
        username
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this)*.role
    }

    boolean containsAuthorities(String... roles) {
        getAuthorities()*.authority.containsAll(roles)
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        password blank: false
        email nullable: true
    }

    static mapping = {
        table 'users'
        password column: '`password`'
        email email: true
    }
}
